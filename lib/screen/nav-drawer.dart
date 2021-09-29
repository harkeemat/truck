import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:truck/network_utils/api.dart';

import 'package:truck/screen/home.dart';
import 'package:truck/screen/jobpost.dart';
import 'package:truck/screen/logout.dart';
import 'package:truck/screen/manage_addresses/manage_addresses_screen.dart';

import 'package:truck/screen/payment.dart';

import 'package:truck/screen/profile.dart';
import 'package:truck/screen/rideBook.dart';


class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  var user;
  String image;
  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');
//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    //print(user);
    // dropdownValue=user['vehicle_type'];
    //print(_dropDownValue);
    setState(() {
      if (user['image'] != null) {
        image = Network().imageget + "/" + user['image'];
        //print(image);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: image == null
                  ? AssetImage("assets/images/logo2.png")
                  : NetworkImage(image),
              backgroundColor: Colors.transparent,
            ),

            // decoration: BoxDecoration(
            // color: globalColor,

            // image:
            // DecorationImage(
            // fit: BoxFit.fill,
            // image:
            // image == null
            // ? AssetImage("assets/images/logo2.png")
            // : NetworkImage(image),
            // )),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Ride-book'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RideBook()))
            },
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('My Jobs'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Jobpost()))
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManageAddressesScreen()))
            },
          ),
          //  ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('homebar'),
          //   onTap: () => {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ProductDetailPage()))
          //   },
          // ),
       
          // ListTile(
          // leading: Icon(Icons.border_color),
          // title: Text('Feedback'),
          // onTap: () => {
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => ))
          // },
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Logout()))
            },
          ),
        ],
      ),
    );
  }
}
