import 'package:chatting_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("S E T T I N G S"),
        //backgroundColor: Colors.purple.shade300,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border()),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",style: TextStyle(fontSize: 20),),
                Switch(value:Provider.of<ThemeProvider>(context, listen: false).isDarkMode, onChanged: (value) {
                  Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
                })
              ],
            )
          ),
        ),
      ),
    );
  }
}