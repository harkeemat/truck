import 'package:flutter/material.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/shop/models/foodCategroyModel.dart';

class FoodCategory extends StatelessWidget {
  final item;

  const FoodCategory({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(Network().imageget + "/" + item.logo,
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}


//leading:Image.asset(item.image),



