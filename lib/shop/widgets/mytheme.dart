import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {

  static ThemeData  lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.red,
      appBarTheme: AppBarTheme(color: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),),
      fontFamily : "lato",
      textTheme: Theme.of(context).textTheme,
      iconTheme: IconThemeData(color: Colors.white),
      cardColor: darkcream,
      canvasColor:Vx.gray100);

  static ThemeData  darkTheme(BuildContext context) => ThemeData(

      primarySwatch: Colors.red,
      appBarTheme: AppBarTheme(color: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),),
      fontFamily : "lato",
      textTheme: Theme.of(context).textTheme,
      iconTheme: IconThemeData(color: Colors.white),
      cardColor: darkcream,
      canvasColor:Vx.gray100);


  // primarySwatch: Colors.red,
      // appBarTheme: AppBarTheme(color: Colors.black,
      // textTheme: Theme.of(context).textTheme,
      // titleTextStyle: TextStyle(color: Colors.white),
      // iconTheme: IconThemeData(color: Colors.white),),
      // fontFamily : "OpenSans",
      // textTheme: Theme.of(context).textTheme.copyWith(headline6: TextStyle(color: Colors.white)),
      // iconTheme: IconThemeData(color: Colors.white),
      // brightness: Brightness.dark,
      // cardColor: black,
      // buttonColor: darlBluishColor,
      // accentColor: Colors.white,
      // canvasColor:darkcream
  


      static Color reddish = Color(0xc6e73c3c);
      static Color cream = Color(0xfff5f5f5);
      static Color black = Color(0xdd0c0202);
      static Color darlBluishColor = Color(0xff403b58);
      static Color lightBluishColor =Colors.red;


    // static Color darkReddish = Vx.red100;
    static Color darkcream = Vx.gray800;


}