import 'package:chatting_app/pages/home_screen.dart';
import 'package:chatting_app/pages/register_screen.dart';
import 'package:chatting_app/services/authentication/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool passwordVisibility = true;

  void login() async{
    //Auth Service
    final authService = AuthService();

    //try Login
    try{
      await authService.signInWithEmailPassword(email.text, password.text,);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    //catch any Error
    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString())));
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login",style: TextStyle(fontSize: 30),),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "email",
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: password,
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          color: Colors.green,
                          icon: Icon(passwordVisibility
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.orange)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Colors.green))),
                  ),

                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: ElevatedButton(onPressed: (){
                      login();
                    }, child: Text("Login")),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?  ",style: TextStyle(color: Colors.grey),),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      child: Text("Register now"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  
}
