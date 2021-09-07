import 'package:flutter/material.dart';

import 'package:truck/shop/models/homeModel.dart';


class HomeProducts extends StatelessWidget {
  final Item item;
  const HomeProducts({Key key, @required this.item})
      // ignore: unnecessary_null_comparison
      : assert(item!=null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Card(
    child: Padding(padding: const EdgeInsets.all(10),
        child: ListTile(
          subtitle: Text(item.desp),
          title: Text(item.name),
          trailing: Text("10.0"),
          leading: Image.network(item.image),
          onTap: (){
            print("${item.name} onPressed");
          },
        )
    )
    );
  }
}
