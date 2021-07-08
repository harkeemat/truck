import 'dart:async';
import 'dart:convert';
// import 'dart:convert';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:truck/main.dart';
// import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/nav-drawer.dart';
// import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:truck/notification/message_list.dart';



class RideBook extends StatefulWidget {
  RideBook({Key key}) : super(key: key);

  @override
  _RideBookState createState() => _RideBookState();
}

class _RideBookState extends State<RideBook> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //final Firestore _db = Firestore.instance;
  Position _currentPosition;
  final TextEditingController _currentController = new TextEditingController();
  final TextEditingController _dropController = new TextEditingController();
  final TextEditingController _luggageController = new TextEditingController();
  final TextEditingController _WeightController = new TextEditingController();
  final TextEditingController _deminishonsController = new TextEditingController();
  final TextEditingController _tokenController = new TextEditingController();
  final dateController = new TextEditingController();
  final dropController = new TextEditingController();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  String isDriver;
 String _dropDownValue;


  
  bool isAuth = false;
  

        static Future<void> sendNotification(receiver,msg,value)async{
          var postUrl = "https://fcm.googleapis.com/fcm/send";

        var token = await getToken(receiver);
        //print('token : $token');

        final data = {
          "notification": {"body": value['body'], "title": value['title']},
          "priority": "high",
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "name":value['name'],
                                    "recever_id":value['recever_id'],
                                    "vehicle_type":value['vehicle_type'],
                                    "mobile_number":value['mobile_number'],
                                    "image":value['image'],
                                    "sender_id":value['sender_id'],
                                    "sender_name":value['sender_name'],
                                    "luggage":value['luggage'],
                                    "Distance":value['Distance'],
                                    "date":value['date'],
                                    "current":value['current'],
                                    "drop":value['drop'],
                                    "dropdate":value['dropdate'],
                                    "deminishons":value['deminishons'],
                                    "Weight":value['Weight'],
                                    "price":value['price'],
                                    "screen": "ridebook"
          },
          "to": value['token']
        };

        final headers = {
          'content-type': 'application/json',
          'Authorization': 'key=AAAAry0Gih4:APA91bH56uF4N4zvCWsVI7EI4q5ubdKGsbl1ZVY3UVI1-MTLXfBppYFLnWlbN1-wU1snuI8eyi_FphmTz_e-GYnP7zZj_cElC42Ga_4ufw1FlRapetZabFrVK324kS6a-jhUSTYk4nmh'
        };


        BaseOptions options = new BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 3000,
          headers: headers,
        );


        try {
          final response = await Dio(options).post(postUrl,
              data: data);
//print('result : $response');
          if (response.statusCode == 200) {
            Fluttertoast.showToast(msg: 'Request Sent To Driver');
          } else {
            print('notification sending failed');
            // on failure do sth
          }
        }
        catch(e){
          print('exception $e');
        }




      }

      static Future<String> getToken(userId)async{

          final FirebaseMessaging _fcm = FirebaseMessaging.instance;

        var token;
        String fcmToken = await _fcm.getToken();
        await FirebaseFirestore.instance.collection('users')
            .doc(userId.toString())
            .collection('tokens').get().then((snapshot){
              snapshot.docs.forEach((doc){
                token = doc.id;
              });
        });

        return fcmToken;


      }
  
  double bearing;
  int km;
  List data;
  List list = [];

  Future<String> getData() async {
    //return await FirebaseFirestore.instance.collection('DriversList').getDocuments();
    firestore.collection("users").get().then((querySnapshot) {
      //print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        //Map<String, dynamic> user = result.data();
        list.add(result.data());
        //data = jsonEncode(opAttrList.map((e) => e.toJson()).toList());

        //list.add(result.data().toString());
      });
      this.setState(() {
        data = list;
      });

      //print(data);
    });
  }

  void lcation() async {
    List<Location> Cunrretlocations =
        await locationFromAddress(_currentController.text);
    List<Location> droplocations =
        await locationFromAddress(_dropController.text);

    setState(() {
      double distanceInMeters = (Geolocator.distanceBetween(
          Cunrretlocations.single.latitude,
          Cunrretlocations.single.longitude,
          droplocations.single.latitude,
          droplocations.single.longitude))/1000;
      bearing = Geolocator.bearingBetween(
          Cunrretlocations.single.latitude,
          Cunrretlocations.single.longitude,
          droplocations.single.latitude,
          droplocations.single.longitude);
      isAuth = true;
      km=distanceInMeters.toInt();
    });

    try {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      }).catchError((e) {
        print(e);
      });

      //print(_currentPosition);
      //print(isAuth);

    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    
    _loadUserData();
  
  }
   _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
   var user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');

//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    //print(user);
    setState(() {
          isDriver=user['role'];
        });
    //isDriver=user['role'];
    //print(_dropDownValue);
    // setState(() {
    //   firstName = user['name'];
    //   mobile=user['mobile_number'];
    //   snn=user['snn'];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Book Ride"),
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Container(
              
              child: isDriver=="driver" ?
                 Column(
                   children: [
                     MetaCard('Ride Accept', MessageList()),
                     Padding(
                       padding: EdgeInsets.all(2),

                     )
                     ],
                   )
                 :
              Column(
                children: <Widget>[
          
                Padding(
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    controller: _currentController,
                    decoration: InputDecoration(
                      hintText: 'Current location',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: TextField(
                    controller: _dropController,
                    decoration: InputDecoration(
                      hintText: 'Drop location',
                    ),
                    onSubmitted: (value) {
                      lcation();
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(2),
                    child: Image.asset(
                      'assets/images/index.jpg',
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                isAuth == true
                    ? Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,  

                              children: [
                                Text("Distance",style: TextStyle(fontSize:25)),

                                Text(km.toString()+" KM",style: TextStyle(fontSize:25)),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextField(
                                readOnly: true,
                                controller: dateController,
                                decoration:
                                    InputDecoration(hintText: 'Pick Date'),
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  dateController.text =
                                      date.toString().substring(0, 10);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextField(
                                readOnly: true,
                                controller: dropController,
                                decoration:
                                    InputDecoration(hintText: 'Drop Date'),
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  dropController.text =
                                      date.toString().substring(0, 10);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextField(
                                controller: _WeightController,
                                decoration: InputDecoration(
                                  hintText: 'Weight',
                                ),
                                // onSubmitted: (value) {
                                //   getData();
                                // },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextField(
                                controller: _deminishonsController,
                                decoration: InputDecoration(
                                  hintText: 'Deminishons',
                                ),
                                // onSubmitted: (value) {
                                //   getData();
                                // },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: TextField(
                                controller: _luggageController,
                                decoration: InputDecoration(
                                  hintText: 'luggage type',
                                ),
                                // onSubmitted: (value) {
                                //   getData();
                                // },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child:DropdownButton(
      hint: _dropDownValue == null
          ? Text('Dropdown')
          : Text(
              _dropDownValue,
              style: TextStyle(color: Colors.blue),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue),
      items: ['Truck', 'Smalltruck'].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownValue = val;
          },
        );
        },
        )
                            ),
                             Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 10, right: 10),
                        child: Text(
                           'Book Ride Now',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      color: Colors.teal,
                      disabledColor: Colors.grey,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      onPressed: () {
                        
                          getData();
                        
                      },
                    ),
                  )
                          ],
                        ),
                      )
                     
                    : Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(children: []),
                      ),
                Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: [
                      new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                           
                          return _dropDownValue==data[index]['vehicle_type'] ?
                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: [
                              
                              ListTile(
                                title: Text(data[index]['name']),
                                isThreeLine: true,
                                subtitle: Text('Secondary text\nTertiary text'),
                                leading: Icon(Icons.label),
                                trailing: Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    value = true;
                                  },
                                ),
                                onTap: () async{
                                   SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = jsonDecode(localStorage.getString('user'));
                                   final sendValue ={
                                     "token":data[index]['token'],
                                      "name":data[index]['name'],
                                      "recever_id":data[index]['id'],
                                      "vehicle_type":data[index]['vehicle_type'],
                                      "mobile_number":data[index]['mobile_number'],
                                      "image":data[index]['image'],
                                      "sender_id":user['id'],
                                      "sender_name":user['name'],
                                      "luggage":_luggageController.text,
                                      "deminishons":_deminishonsController.text,
                                      "Weight":_WeightController.text,
                                      "dropdate":dropController.text,
                                      "Distance":km.toString(),
                                      "date":dateController.text,
                                      "current":_currentController.text,
                                      "drop":_dropController.text,
                                      "title":"Click to Ride Book",
                                      "body":"Accept the booking"

                                   };
                                  sendNotification(21,"how are you",sendValue);
                                     //print(sendValue);
                                }
                              ) 
                              
                            ],
                          ) : Center();
                        },
                      ),
                    ],
                  ),
                ),
              ]
              ),
            ),
          )),
    );
  }
}
