library globals;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

int globalInt = 0;
int globalbrandid = 1;
bool globalBoolean = true;
bool globalisbrand = false;
bool globaliscategory = false;
bool globalisproduct = false;
String globalbranname = "";
String globalsearchword = "";
String globalString = "";
String globalRole = "";
double globalDouble = 10.0;
String globaladdresid = '';
List<RemoteMessage> globallist = [];

Color globalColor = _colorFromHex("30B7A9");
Color globalbutton = _colorFromHex("e20612");

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
