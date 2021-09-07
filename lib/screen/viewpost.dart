import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truck/model/jobPost.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/nav-drawer.dart';

import 'my-globals.dart' as globals;

class ViewPost extends StatefulWidget {
  final userdata;
  const ViewPost({Key key, this.userdata}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState(userdata: this.userdata);
}

class _ViewPostState extends State<ViewPost> {
  final userdata;
  _ViewPostState({this.userdata});
  List joblist;

  fetchInfo() async {
    //print("${userdata['order_number']}");
    var res = await Network().getData('/order/${userdata['order_number']}');
    final jsonresponse = json.decode(res.body);
    //print(jsonresponse);
    this.setState(() {
      joblist = jsonresponse['data'];
    });

    ///return JobPost.fromJson(jsonresponse['data'][0]);
  }

  @override
  void initState() {
    super.initState();
    fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: globalColor,
        title: Text("Job Detail"),
      ),
      body: SingleChildScrollView(
          child: new Center(
              child: new Column(children: <Widget>[
        joblist != null
            ? new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: joblist == null ? 0 : joblist.length,
                itemBuilder: (BuildContext context, int index) {
                  //print(index);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: globalColor,
                    elevation: 30,
                    child: Column(
                      children: [
                        Text(
                            "Order Number ${(joblist[index]['order_number']).toString()}",
                            style: TextStyle(color: Colors.grey, fontSize: 20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Driver Name :",
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 18),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                    "${(joblist[index]['driver']['name']).toString()}",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Client Name :",
                                  style: TextStyle(
                                      color: Colors.white60, fontSize: 18)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text("${joblist[index]['user']['name']}",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 20)),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                              color: globalColor,
                            ),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Text('Commodity ',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white70))
                                ]),
                                Column(children: [
                                  Text('Weight',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white70))
                                ]),
                                Column(children: [
                                  Text('Price ()',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white70))
                                ]),
                                // Column(children: [
                                // Text('Status',
                                // style: TextStyle(fontSize: 20.0,
                                // color: Colors.white70))
                                // ]),
                              ]),
                              TableRow(children: [
                                Column(children: [
                                  Text("${joblist[index]['commodity']}",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 20)),
                                ]),
                                Column(children: [
                                  Text("${joblist[index]['weight']}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 20,
                                      ))
                                ]),
                                Column(children: [
                                  Text(
                                      "${joblist[index]['receivedquotations'][index]['price']}",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 20))
                                ]),
                                // Column(children: [
                                // Text(
                                // joblist[1]['status'] == 5
                                // ? "On the way"
                                // : "Order Placed",
                                // style: TextStyle(
                                // color: Colors.white30, fontSize: 20))
                                // ]),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
            : Padding(
                child: Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
                padding: EdgeInsets.only(top: height / 2.3)),
      ]))),
    );
  }
}
