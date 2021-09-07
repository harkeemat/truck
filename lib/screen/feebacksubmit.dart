import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/home.dart';

class Feedbacksubmit extends StatefulWidget {
  final feedbackdata;
  const Feedbacksubmit({Key key, this.feedbackdata}) : super(key: key);

  @override
  _FeedbacksubmitState createState() =>
      _FeedbacksubmitState(feedbackdata: this.feedbackdata);
}

class _FeedbacksubmitState extends State<Feedbacksubmit> {
  final feedbackdata;
  _FeedbacksubmitState({this.feedbackdata});

  submit() async {
    var res = await Network().authData(feedbackdata, '/user_rating');
    var body = json.decode(res.body);

    //print(body);
    if (res.statusCode == 201) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    super.initState();

    submit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
