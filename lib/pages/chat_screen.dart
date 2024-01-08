import 'package:chatting_app/services/authentication/auth_service.dart';
import 'package:chatting_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  String userMail;
  String recieverId;
  ChatScreen({super.key,required this.userMail,required this.recieverId});

  ChatService chatService = ChatService();

  AuthService authService = AuthService();

  var messageController = TextEditingController();

  void sendMessage() async{
    if(messageController.text.isNotEmpty){
      //send the message
      await chatService.sendMessage(recieverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(userMail),
          //backgroundColor: Colors.purple.shade300,
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a Message"
                      ),
                    )),
                    SizedBox(width: 20,),
                    Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.circular(30)
                    ),
                      child: IconButton(onPressed: (){
                        sendMessage();
                      }, icon: Icon(Icons.arrow_right_alt,color: Colors.white,)),
                    )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream : chatService.getMesssage(recieverId,senderId),
      builder: (context,snapshot) {
        //error
        if(snapshot.hasError){
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(child: Text("Error")),
          );
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(child: CircularProgressIndicator(),),
          );
        }

        //return list view

        if(snapshot.data!.docs.length == 0){
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message,size: 60,),
                SizedBox(height: 20,),
                Text("Start Your Chat to Make a Connection",style: TextStyle(fontSize: 20,),)
              ],
            ),
          );
        }

        return ListView(
          padding: EdgeInsets.all(5),
          children: snapshot.data!.docs.map<Widget>((doc) {

            //is current user
            bool isCurrentUser =  doc['senderId'] == authService.getCurrentUser()!.uid;

            //Align sender messages to right and reciever messages to left 
            var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

            print("Saikumar");


            return Column(
              crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                     padding: EdgeInsets.all(10),
                     margin: EdgeInsets.all(5),
                     decoration: BoxDecoration(color: isCurrentUser ? Colors.green.shade900 : Colors.blueGrey,borderRadius: isCurrentUser ? BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(15)) : BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(15))),
                     child: Text(
                      doc["message"],
                      style: TextStyle(color: Colors.white),
                      )),
              ],
            );
        }).toList(),
        );
      },
    );
  }
}