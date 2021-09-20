import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:truck/model/data.dart';
import 'package:truck/model/product.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/product/product_detail.dart';
import 'package:truck/theme/light_color.dart';
import 'package:truck/theme/theme.dart';
import 'package:truck/widget/prduct_icon.dart';
import 'package:truck/widget/product_card.dart';
import 'package:truck/widget/title_text.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.proid}) : super(key: key);

  final proid;

  @override
  _MyHomePageState createState() => _MyHomePageState(proid: this.proid);
}

class _MyHomePageState extends State<MyHomePage> {
  final proid;
  _MyHomePageState({this.proid});
  bool isSelected = true;
  bool isliked = false;
  List productmodel;
  productcat() async {
    var res = await Network().getData('/getproduct/$proid');

    final jsonresponse = json.decode(res.body);
    //print(jsonresponse['data']);
    setState(() {
      productmodel = jsonresponse['data'];
    });

    //final List<Item> foodCategoryList = jsonresponse['data'];
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: AppData.categoryList
              .map((category) => ProducIcon(
                    model: category,
                  ))
              .toList()),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: productmodel != null
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 20),
              itemCount: productmodel == null ? 0 : productmodel.length,
              itemBuilder: (BuildContext ctx, index) {
                final product = productmodel[index];
                return productdata(product);
              })
          : Center(child: CircularProgressIndicator()),
      // GridView.count(
      //     primary: false,
      //     padding: const EdgeInsets.all(20),
      //     crossAxisSpacing: 10,
      //     mainAxisSpacing: 10,
      //     crossAxisCount: 2,
      //     children: <Widget>[
      //       productmodel != null
      //           ? new ListView.builder(
      //               itemCount: productmodel == null ? 0 : productmodel.length,
      //               itemBuilder: (BuildContext context, int index) {
      //                 final product = productmodel[index];
      //                 return productdata(product);
      //               })
      //           : Center(child: CircularProgressIndicator()),
      //     ]
      //     //Your item

      //     )
    );
  }

  Widget productdata(product) {
    return InkWell(
      onTap: () {
        //print(widget.product.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailPage(itemId: product['id'])));
        // setState(() {
        //   model.isSelected = !model.isSelected;
        //   AppData.productList.forEach((x) {
        //     if (x.id == model.id && x.name == model.name) {
        //       return;
        //     }
        //     x.isSelected = false;
        //   });
        //   var m = AppData.productList
        //       .firstWhere((x) => x.id == model.id && x.name == model.name);
        //   m.isSelected = !m.isSelected;
        //   print(m.isSelected);
        // });
      },
      child: Container(
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: isSelected ? 20 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                    icon: Icon(
                      isliked ? Icons.favorite : Icons.favorite_border,
                      color: isliked ? LightColor.red : LightColor.iconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isliked = true;
                      });
                    })),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // SizedBox(height: isSelected ? 15 : 0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: LightColor.orange.withAlpha(40),
                    ),
                    Image.network(
                      Network().imageget + "/" + product['image'],
                      height: 80,
                    )
                  ],
                ),
                // SizedBox(height: 5),
                TitleText(
                  text: product['name'],
                  fontSize: isSelected ? 16 : 14,
                ),
                TitleText(
                  text: product['name'],
                  fontSize: isSelected ? 14 : 12,
                  color: LightColor.orange,
                ),
                TitleText(
                  text: product['price'].toString(),
                  fontSize: isSelected ? 18 : 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Products",
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 5),
                    prefixIcon: Icon(Icons.search, color: Colors.black54)),
              ),
            ),
          ),
          SizedBox(width: 20),
          _icon(Icons.filter_list, color: Colors.black54),
        ],
      ),
    );
  }

  @override
  void initState() {
    productcat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_categoryWidget(), _productWidget()],
    );
  }
}
