import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:truck/model/cartmodel.dart';
import 'package:truck/screen/login.dart';
import 'package:truck/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/nav-drawer.dart';
import 'package:truck/shop/screens/cart/cart_page.dart';
import 'package:truck/shop/screens/home/home.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;
  String image;
  @override
  void initState() {
    //_response();
    _getCurrentLocation();
    _loadUserData();

    //_read();
    super.initState();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');

//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    // print(user);
    if (user != null) {
      setState(() {
        name = user['name'];
        globalRole = user['role'];
        if (user['image'] != null) {
          image = Network().imageget + "/" + user['image'];
          //print(image);
        }
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Position _currentPosition;
  bool isAuth = false;

  void _create() async {
    //_getCurrentLocation();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    String name = (user['id']).toString();
    //print("name :$name");
    String token = await FirebaseMessaging.instance.getToken();
    //print(token);
    try {
      _getCurrentLocation();
      //print(name);
      //print(isAuth);
      isAuth = true;
      await firestore.collection('users').doc(name).set({
        'id': user['id'],
        'name': user['name'],
        'image': user['image'],
        'role': user['role'],
        'licence': user['licence'],
        'vehicle_type': user['vehicle_type'],
        'mobile_number': user['mobile_number'],
        'snn': user['snn'],
        'latitude': _currentPosition.latitude,
        'longitude': _currentPosition.longitude,
        'token': token,
      });
    } catch (e) {
      print(e);
    }
  }

  // void _response() async {
  //print("fsfdsf$user");
  //String sender_id = (21).toString();
  //String recever_id = (globalInt).toString();
  // await firestore.collection((27).toString()).doc((22).toString()).set({
  // 'driver_id': globalInt,
  // 'price': '30',
  // 'client_id': 24,
  // 'order_number': "4324324",
  // });
  // }
//
  void _read() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    String name = (user['id']).toString();
    String token = await FirebaseMessaging.instance.getToken();
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('users').doc(name).get();
      //print();
      if (documentSnapshot.data() != null) {
        print(documentSnapshot.id + "id");
        setState(() {
          isAuth = true;
        });
      }
      //print(documentSnapshot.id);
    } catch (e) {
      print(e);
    }
    if (globalRole == "client") {
      await firestore.collection('client').doc(name).set({
        'id': user['id'],
        'name': user['name'],
        'image': user['image'],
        'role': user['role'],
        'mobile_number': user['mobile_number'],
        'latitude': _currentPosition.latitude,
        'longitude': _currentPosition.longitude,
        'token': token,
      });
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
    String name = (user['id']).toString();
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        actions: [
          globalRole != "client"
              ? isAuth == true
                  ? FlatButton(
                      color: globalbutton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text("Click to Offline",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _delete();
                        setState(() {
                          isAuth = false;
                        });
                      },
                    )
                  : FlatButton(
                      color: globalbutton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text("Click to Online",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        _create();
                        setState(() {
                          isAuth = true;
                        });
                      },
                    )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkResponse(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                      child: Stack(
                        children: [
                          Align(
                            child: Text(ScopedModel.of<CartModel>(context,
                                            rebuildOnChange: true)
                                        .cart
                                        .length >
                                    0
                                ? ScopedModel.of<CartModel>(context,
                                        rebuildOnChange: true)
                                    .cart
                                    .length
                                    .toString()
                                : ''),
                            alignment: Alignment.topLeft,
                          ),
                          Align(
                            child: Icon(Icons.shopping_cart),
                            alignment: Alignment.center,
                          ),
                        ],
                      )),
                ),
        ],
        title: Text('Dashboard'),
        backgroundColor: globalColor,
        
      ),
      body: globalRole == "client"
          ? HomeScreen()
          : Stack(
       
        children: <Widget>[
          
          
          
          Container(
            height: size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.topCenter,
              image: Image.network(
                      "https://mars-metcdn-com.global.ssl.fastly.net/content/uploads/sites/101/2019/04/30162428/Top-Header-Background.png")
                  .image,
            )),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 62,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 62,
                        backgroundImage: NetworkImage(image != null
                            ? image
                            : "https://smoothmove.co.za/wp-content/uploads/2021/02/pp1.jpg"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name != null ? name : "",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3),
                          ),
                          Text(
                            globalRole != null ? globalRole : "client",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://st2.depositphotos.com/5425740/9532/v/380/depositphotos_95328970-stock-illustration-vector-group-of-students.jpg",
                              height: 120,
                            ),
                            Text('All Ride'),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://www.vettrak.com.au/wp-content/uploads/2020/02/international_students.png",
                              height: 120,
                            ),
                            Text('New Ride'),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://www.smallbizdaily.com/wp-content/uploads/2021/01/shutterstock_1746002939-1.jpg",
                              height: 120,
                            ),
                            Text('Upcoming Events'),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://pngimage.net/wp-content/uploads/2018/06/homework-cartoon-png-2.png",
                              height: 120,
                            ),
                            Text('Holiday Trip'),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://i.pinimg.com/originals/55/69/55/5569554b4d8a9bb11965949e1af08dbf.png",
                              height: 120,
                            ),
                            Text('Get Record'),
                          ],
                        ),
                      ),
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTku2oJC2M9rZu0jq3hLd7n_lgwUEFudUCVLu_XOo7bY0V_7ih5LsWA9p2LBVPFNkbVZx8&usqp=CAU",
                              height: 120,
                            ),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          
          
          

        ],
      ),
    );
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //print(localStorage);
    if (user != null) {
      //SharedPreferences localStorage = await SharedPreferences.getInstance();
      //await localStorage.clear();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _read();
    }).catchError((e) {
      print(e);
    });
  }
}
