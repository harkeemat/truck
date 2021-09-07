import 'package:flutter/material.dart';
import 'package:truck/shop/models/foodCategroyModel.dart';

//import 'package:food_app/screens/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../mytheme.dart';

class CatelogItem extends StatelessWidget {
  final Item catalog;
  // ignore: unnecessary_null_comparison
  const CatelogItem({Key key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
          tag: Key(catalog.image),
          child: CatelogImage(image: catalog.image),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            catalog.name.text.xl.bold.color(MyTheme.black).make(),
            catalog.desp.text.medium.color(MyTheme.black).make(),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                "\$${catalog.price}".text.bold.medium.make(),
                ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyTheme.reddish),
                            shape: MaterialStateProperty.all(StadiumBorder())),
                        child: "Add to cart".text.make())
                    .h(30)
              ],
            )
          ],
        ).p1())
      ],
    )).white.rounded.square(150).make().p8();
  }
}

class CatelogImage extends StatelessWidget {
  final String image;
  // ignore: unnecessary_null_comparison
  const CatelogImage({Key key, @required this.image})
      : assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .color(MyTheme.cream)
        .make()
        .p16()
        .wh(150, 150);
  }
}
