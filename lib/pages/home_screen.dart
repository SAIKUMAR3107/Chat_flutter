import 'package:chatting_app/pages/chat_screen.dart';
import 'package:chatting_app/pages/login_screen.dart';
import 'package:chatting_app/pages/settings_screen.dart';
import 'package:chatting_app/services/authentication/auth_service.dart';
import 'package:chatting_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Chat With..",style: TextStyle(fontSize: 30),),
              SizedBox(height: 15,),
              Icon(
                Icons.message,
                size: 90,
              ),
              SizedBox(height: 10,),
              Text("Email : "+authService.getCurrentUser()!.email!),
              SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: (){
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home,
                    color: Color(0xffF67952)),
                title: Text('Home'),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
                },
                leading: Icon(Icons.sunny,
                    color: Color(0xffF67952)),
                title: Text('Settings'),
              ),
              Spacer(),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                leading: Icon(Icons.logout,
                    color: Color(0xffF67952)),
                title: Text('Logout'),
              ),
              
              SizedBox(height: 20,)
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Chat With.."),
          centerTitle: true,
        ),
        body: _buildUserList(),
      ),
    );
  }
  
  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatService.getUserStream(),
      builder: (context, snapshot) {

        
        
        //error
        if(snapshot.hasError){
          return Text("Error");
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator()));
        }

        //return list view
        return ListView(
          padding: EdgeInsets.all(10),
          children: snapshot.data!.map<Widget>((userData) {
            
            
            if(userData["email"] != authService.getCurrentUser()!.email){
              return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(userMail: userData["email"],recieverId: userData["uid"],)));
              },
              child: Card(elevation: 30,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(25)),
                        child: Icon(Icons.person)),
                      SizedBox(width: 10,),
                      Text(userData["email"])
                    ],
                  ),
                ),
              ),

            );
            }
            else {
              return Container();
            }
            
          }).toList(),
        );
        
      },
    );
  }
}
