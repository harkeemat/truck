import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truck/shop/screens/home/home.dart';
import 'package:truck/shop/screens/myAccount/profile.dart';

import 'package:truck/shop/utlis/platte.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: kBodyNrmlText,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red[300]),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black12,
                    child: Text(
                      "",
                      style: ksmallText,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "vineeta chauhan",
                      style: ksmallText,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
                leading: Icon(CupertinoIcons.home),
                title: Text(
                  "Home",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    )),
            ListTile(
                leading: Icon(CupertinoIcons.profile_circled),
                title: Text("Profile", style: kNavigationText),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                    )),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: kNavigationText),
              selected: true,
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
