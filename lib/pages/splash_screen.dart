import 'dart:async';
import 'package:chatting_app/pages/home_screen.dart';
import 'package:chatting_app/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void shared() async{
    var shared =await SharedPreferences.getInstance();
    print(shared.getBool("isLogin"));
    if(shared.getBool("isLogin") == null || shared.getBool("isLogin") == false){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shared();
    Timer(Duration(seconds: 3), () { 
      
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat,size: 50,),
            SizedBox(height: 10,),
            Text("Chat With..",style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}