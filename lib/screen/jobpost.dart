import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/model/jobPost.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/map_screen.dart';
import 'package:truck/screen/my-globals.dart';

import 'package:truck/screen/startride.dart';
import 'package:truck/screen/test.dart';
import 'package:truck/screen/viewpost.dart';
import 'my-globals.dart' as globals;
import 'package:truck/screen/nav-drawer.dart';

class Jobpost extends StatefulWidget {
  Jobpost({Key key}) : super(key: key);

  @override
  _JobpostState createState() => _JobpostState();
}

class _JobpostState extends State<Jobpost> {
  String name;
  List alertdata;
  List alert = [];
  Future<JobPost> fetchInfo() async {
    if (globals.globalString == "client") {
      var res = await Network().getData('/orders/${globals.globalInt}');
      final jsonresponse = json.decode(res.body);

      name = jsonresponse['name'];
      //print(jsonresponse['data'][0]);
      this.setState(() {
        alertdata = jsonresponse['data'];
      });
      //print(alertdata);

      return JobPost.fromJson(jsonresponse['data'][0]);
    } else {
      var res = await Network().getData('/orders_driver/${globals.globalInt}');
      final jsonresponse = json.decode(res.body);

      name = jsonresponse['name'];
      //print(jsonresponse['data'][0]);
      this.setState(() {
        alertdata = jsonresponse['data'];
      });
      //print(alertdata);
      return JobPost.fromJson(jsonresponse['data'][0]);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
    //_loadUserData();
    //print(globals.globalInt);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: globalColor,
          title: Text("Job Post"),
        ),
        body: SingleChildScrollView(
          child: new Center(
            child: new Column(
              children: <Widget>[
                alertdata != null
                    ? new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: alertdata == null ? 0 : alertdata.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: globalColor,
                            elevation: 30,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Order No=> ${alertdata[index]['order_number']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: globals.globalString == "client"
                                            ? Text("Driver name=> $name",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12))
                                            : Text("Client name=> $name",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                            "Pick Up Loaction=> ${alertdata[index]['pickup_location']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            "Drop Location=> ${alertdata[index]['drop_location']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                            "Pick Up Date=> ${alertdata[index]['pickdate']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                            "Drop Date=> ${alertdata[index]['dropdate']} sddsd ${alertdata[index]['status']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                  ButtonTheme(
                                    child: ButtonBar(
                                      children: <Widget>[
                                        FlatButton(
                                          color: globalbutton,
                                          child: const Text('View',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewPost(
                                                            userdata: alertdata[
                                                                index])));
                                            //print("gjhghj");
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  ButtonTheme(
                                    child: ButtonBar(
                                      children: <Widget>[
                                        alertdata[index]['status'] != "2"
                                            ? FlatButton(
                                                color: globalbutton,
                                                child: const Text("start",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MapScreen(
                                                                  userdata:
                                                                      alertdata[
                                                                          index])));
                                                },
                                              )
                                            : FlatButton(
                                                color: globalbutton,
                                                child: const Text("Complete",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                                onPressed: () {
                                                  Test();
                                                })
                                      ],
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          );
                        })
                    : Padding(
                        child: Container(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        padding: EdgeInsets.only(top: height / 2.3)),
              ],
            ),
          ),
        ));
  }
}
