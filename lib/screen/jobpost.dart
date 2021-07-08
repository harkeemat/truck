import 'package:flutter/material.dart';
import 'package:truck/screen/nav-drawer.dart';
class Jobpost extends StatefulWidget {
  Jobpost({Key  key}) : super(key: key);

  @override
  _JobpostState createState() => _JobpostState();
}

class _JobpostState extends State<Jobpost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Job Post"),
      ),
      body:Center(
        child:Text("job post"),
      )
    );
  }
}