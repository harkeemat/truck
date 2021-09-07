import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientColor extends StatelessWidget {
  final String image;

  const GradientColor({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this context is a peace of info ....whic tell us location of widegert in tree like struct.

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
      ),
    );
  }
}
