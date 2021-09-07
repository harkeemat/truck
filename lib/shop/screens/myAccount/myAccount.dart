import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:truck/shop/screens/myAccount/profile.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[800]),
        backgroundColor: Colors.white,
        title: Text(
          "My Account",
          style: kBodyNrmlRedText,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 18.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              );
            }),
        elevation: 2,
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              ListTile(
                  leading: Icon(
                    CupertinoIcons.cart_fill_badge_plus,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Orders",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    CupertinoIcons.suit_heart_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Favorites",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    CupertinoIcons.bag_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Address",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    Icons.local_offer_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Discounts",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    CupertinoIcons.bell_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Notifications",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Rate Us",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                  leading: Icon(
                    CupertinoIcons.doc_text_fill,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Ters & Conditions",
                    style: kNavigationText,
                  ),
                  selected: true,
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavBar(),
                        ),
                      )),
              ListTile(
                leading: Icon(
                  CupertinoIcons.headphones,
                  color: Colors.black,
                ),
                title: Text("Help & Support", style: kNavigationText),
                selected: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: Text("Settings", style: kNavigationText),
                selected: true,
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.lock_fill,
                  color: Colors.black,
                ),
                title: Text("Logout", style: kNavigationText),
                selected: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
