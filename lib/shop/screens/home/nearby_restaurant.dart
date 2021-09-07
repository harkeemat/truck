import 'package:flutter/material.dart';

import 'package:truck/shop/models/nearby_restaurant_model.dart';

class NearByReataurant extends StatelessWidget {
  final ReaustrantItem item;

  const NearByReataurant({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
          child: Card(
        elevation: 2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.all(6.0),
                child: Image.network(item.image, fit: BoxFit.fill)),
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
            )
          ],
        ),
      ));
}
