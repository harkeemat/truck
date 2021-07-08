import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:truck/screen/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/nav-drawer.dart';
class Logout extends StatefulWidget {
  @override
  _logout createState() => _logout();
}

class _logout extends State<Logout>{
  String name;
  @override
  void initState() {
    logout();
    super.initState();
    

  }
  
    @override
    Widget build(BuildContext context) {
        return Scaffold(
         
        );
      }

  void logout() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //print(localStorage);
    if(user != null) {
      //SharedPreferences localStorage = await SharedPreferences.getInstance();
      //await localStorage.clear();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }
}