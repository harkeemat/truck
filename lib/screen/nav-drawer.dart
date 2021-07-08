
import 'package:flutter/material.dart';
import 'package:truck/screen/home.dart';
import 'package:truck/screen/jobpost.dart';
import 'package:truck/screen/logout.dart';
import 'package:truck/screen/profile.dart';
import 'package:truck/screen/rideBook.dart';
import 'package:truck/screen/setting.dart';


class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/logo.png'))
                    ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Home()))},
          ),
          
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Ride-book'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>RideBook()))},
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Job Post'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Jobpost()))},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Profile()))},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Setting()))},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Logout()))},
            
          ),
        ],
      ),
    );
 
  
   }
}