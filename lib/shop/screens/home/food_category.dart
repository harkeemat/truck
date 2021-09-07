import 'package:flutter/material.dart';
import 'package:truck/shop/models/foodCategroyModel.dart';

class FoodCategory extends StatelessWidget {
  final Item item;

  const FoodCategory({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(item.image, fit: BoxFit.fill),
        ),
      ),
    );
  }
}


//leading:Image.asset(item.image),



