import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/notification/message_list.dart';
import 'package:truck/main.dart';
import 'package:truck/screen/my-globals.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
    // leading:BackButton(),
    backgroundColor: globalColor,

    elevation: 0,
    actions: [
      IconButton(
          icon: Icon(icon),
          onPressed: () {
            MetaCard('Message Stream', MessageList());
          })
    ],
  );
}
