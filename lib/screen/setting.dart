import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/nav-drawer.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';



class Setting extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<Setting> {
//final Future<FirebaseApp> firestore = Firebase.initializeApp();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Position _currentPosition;
 
  bool isAuth = false;
 
@override
  void initState() {
    super.initState();
   _getCurrentLocation();
   _read();
  }

  void _create() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    String name=(user['id']).toString();
    //print("name :$name");
     String token = await FirebaseMessaging.instance.getToken();
     //print(token);
    try {
     
  _getCurrentLocation();
      //print(_currentPosition);
      //print(isAuth);
      isAuth = true;

      await firestore.collection('users').doc(name).set({
        'id': user['id'],
        'name': user['name'],
        'image': user['image'],
        'role': user['role'],
        'vehicle_type': user['vehicle_type'],
        'mobile_number': user['mobile_number'],
        'snn': user['snn'],
        'latitude':_currentPosition.latitude,
        'longitude':_currentPosition.longitude,
        'token':token,
       

        
      });
      
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    String name=(user['id']).toString();
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').doc(name).get();
      //print();
      if(documentSnapshot.data() != null){
        print(documentSnapshot.id+"id");
        setState(() {
                  isAuth = true;
                });
      }
      
      print(documentSnapshot.id);
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore.collection('users').doc('testUser').update({
        'firstName': 'Alan',
      });
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    String name=(user['id']).toString();
    
    try {
      firestore.collection('users').doc(name).delete();
      //print(name);
      
      print(isAuth);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("App Online OR Offile"),
      ),
     body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            if (_currentPosition != null) Text(
              "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"
            ),
if(isAuth==true) 
  FlatButton(
               
              child: Text("Click to Offline"),
              onPressed: () {
                _delete();
                setState(() {
                  isAuth = false;
                });
                
                
              },
            )
else 
  FlatButton(
               
              child: Text("Click to Online"),
              onPressed: () {
                _create();
                setState(() {
                  isAuth = true;
                });
              },
            )
             
            
          ],
        ),
      
    );
  }
  _getCurrentLocation() {
    Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
      .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      }).catchError((e) {
        print(e);
      });
  }
}