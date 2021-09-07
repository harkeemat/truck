import 'package:flutter/material.dart';
import 'package:truck/screen/quick_feedback.dart';

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({
    Key key,
    @required this.widget,
    @required Icon currentFace,
  })  : _currentFace = currentFace,
        super(key: key);

  final QuickFeedback widget;
  final Icon _currentFace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(widget.title),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          child: _currentFace,
        ),
      ],
    );
  }
}