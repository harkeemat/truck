import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/notification/message_list.dart';
import 'package:truck/main.dart';
AppBar buildAppBar(BuildContext context){
  final icon=CupertinoIcons.moon_stars;
  return AppBar(
    // leading:BackButton(),
    backgroundColor: Colors.teal,
    
    elevation: 0,
    actions: [
      IconButton(icon: Icon(icon), 
      onPressed: (){
        MetaCard('Message Stream', MessageList());
      })
    ],
  );
}