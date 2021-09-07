import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:truck/screen/quick_feedback.dart';
import 'package:truck/widget/feedback_content.dart';
import 'package:truck/widget/feedback_title.dart';

class CupertinoFeedbackDialog extends StatelessWidget {
  final TextField feedbackTextBox;

  final List<Widget> stars;

  final QuickFeedback widget;

  final Icon currentFace;

  final int rating;

  final TextEditingController feedbackEditingController;

  CupertinoFeedbackDialog({
    @required this.stars,
    @required this.widget,
    @required this.rating,
    @required this.currentFace,
    @required this.feedbackTextBox,
    @required this.feedbackEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoAlertDialog(
        title: FeedbackTitle(widget: widget, currentFace: currentFace),
        content: FeedbackContent(
          stars: stars,
          widget: widget,
          textBoxWidget: feedbackTextBox,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.onAskLaterCallback is Function) {
                widget.onAskLaterCallback();
              }
            },
            child: Text(widget.askLaterText),
          ),
          CupertinoDialogAction(
            onPressed: () => widget.onSubmitted({
              'rating': rating,
              'feedback': feedbackEditingController.text,
            }),
            child: Text(widget.submitText),
          )
        ],
      ),
    );
  }
}
