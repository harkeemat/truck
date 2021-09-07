import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/feebacksubmit.dart';
import 'package:truck/screen/jobpost.dart';
import 'package:truck/screen/quick_feedback.dart';

class FeedbackRate extends StatefulWidget {
  const FeedbackRate({Key key}) : super(key: key);

  @override
  _FeedbackRateState createState() => _FeedbackRateState();
}

class _FeedbackRateState extends State<FeedbackRate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: FlatButton(
              onPressed: () => _showFeedback(context, 21, 27),
              child: Text('Feedback'),
            ),
          ),
        ),
      ),
    );
  }

  void _showFeedback(context, userid, reciverid) {
    print(context);
    showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a feedback', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Share your feedback', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitted: (feedback) {
            //print(feedback['rating']);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Feedbacksubmit(feedbackdata: {
                          'booking_number': 3432432,
                          'rating': feedback['rating'],
                          'feedback': feedback['feedback'],
                          'author_id': userid,
                          'author_type': "client",
                          'ratingable_id': reciverid,
                          'ratingable_type': "driver",
                        })));

            //
            //print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
            // Navigator.of(context).pop();
          },
          askLaterText: 'ASK LATER',
          onAskLaterCallback: () {
            print('Do something on ask later click');
          },
        );
      },
    );
  }
}
