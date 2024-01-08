import 'package:auth/auth.dart';
import 'package:chatting_app/pages/home_screen.dart';
import 'package:chatting_app/pages/login_screen.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomeScreen();
          }
          else{
            return LoginScreen();
          }
        }),
    );
  }
}