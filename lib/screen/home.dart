import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:truck/screen/login.dart';
import 'package:truck/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/nav-drawer.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String name;
  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');
     
//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
       // print(user);
    if(user != null) {
      setState(() {
        name = user['name'];
      });
    }
  }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: Text('Test App'),
            backgroundColor: Colors.teal,
            
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Hi, $name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: (){
                        logout();
                      },
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('Logout'),
                    ),
                  ),
                ],
              ),
          ),
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