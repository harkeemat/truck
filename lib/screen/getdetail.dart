import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/model/user.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';

class Getdetail extends StatefulWidget {
  final id;
  const Getdetail({Key key, this.id}) : super(key: key);

  @override
  _GetdetailState createState() => _GetdetailState(id: this.id);
}

class _GetdetailState extends State<Getdetail> {
  final id;
  _GetdetailState({this.id});
  Future<User> getuserid(value) async {
    var res = await Network().getData('/get_user/$value');
    //print("fsfdfsd $res");
    final jsonresponse = json.decode(res.body);
    //print("fsfdfsd $jsonresponse");

    return User.fromJson(jsonresponse['data']);
  }

  @override
  void initState() {
    // final user = getid(27);
    //print("fsfdfsd $id");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalColor,
      ),
      body: SafeArea(
        child: new Column(children: <Widget>[
          new FutureBuilder(
              future: getuserid(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          child: Container(
                            alignment: Alignment(0.0, 2.5),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                              radius: 60.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        snapshot.data.name,
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.blueGrey,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Belgaum, India",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "App Developer at XYZ Company",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          elevation: 2.0,
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: Text(
                                "Skill Sets",
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300),
                              ))),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Good",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Rides",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "15",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Feedback",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "10",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.pink, Colors.redAccent]),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 100.0,
                                  maxHeight: 40.0,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Contact me",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.pink, Colors.redAccent]),
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 100.0,
                                  maxHeight: 40.0,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Portfolio",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return new Text("Error ${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              })
        ]),
      ),
    );
  }
}
