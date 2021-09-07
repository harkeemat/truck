import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this context is a peace of info ....whic tell us location of widegert in tree like struct.

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
      ),
    );

    // return ShaderMask(shaderCallback: (bound) => LinearGradient(colors: [Colors.black , Colors.black12],
    // begin: AlignmentDirectional.center,
    // end: Alignment.center,).createShader(bound),
    // blendMode: BlendMode.darken,
    // child:   Container(
    //   decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/bg.jpeg"),
    //       fit: BoxFit.cover ,colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)),
    //   ),
    //  ),);
  }
}
