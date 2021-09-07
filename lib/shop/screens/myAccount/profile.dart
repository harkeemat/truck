import 'package:flutter/material.dart';

import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              );
            }),
        elevation: 0.0,
        backgroundColor: Colors.pink,
        title: Text(
          "User Profile",
          style: kBodyNrmlText,
        ),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
