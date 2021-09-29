import 'package:flutter/material.dart';
import 'package:truck/model/top_pick_for_model.dart';

class TopPickFood extends StatelessWidget {
  final TopPickItems item;
  const TopPickFood({Key key, @required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Card(
      elevation: 2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 80,
              width: 120,
              margin: EdgeInsets.all(6.0),
              child: Image.network(item.image, fit: BoxFit.cover)),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "22 Queen street",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Freid reice meal",
                    style: TextStyle(
                      fontSize: 10,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
