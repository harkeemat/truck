import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:truck/model/cartmodel.dart';
import 'package:truck/network_utils/api.dart';

import 'package:truck/screen/product/checkout.dart';
import 'package:truck/screen/product/product_detail.dart';
import 'package:truck/utlis/platte.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<Cart> {
  String _price = "\$10";
  String _totalPrice = "\$78";
  int brandid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[800]),
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: kBodyNrmlRedText,
        ),
        // leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     iconSize: 18.0,
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => BottomNavBar()),
        //       );
        //     }),
        elevation: 2,
      ),
      body: ListView(
        children: [
          Container(
            child: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                        .cart
                        .length ==
                    0
                ? Text("No items in Cart")
                : ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    itemCount: ScopedModel.of<CartModel>(context,
                            rebuildOnChange: true)
                        .total,
                    itemBuilder: (context, index) {
                      return ScopedModelDescendant<CartModel>(
                          builder: (context, child, model) {
                        brandid = model.cart[index].brandid;
                        //print(model.cart[index]);
                        return CartData(item: model.cart[index]);
                      });
                    }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("Delivery Location", style: kNormalBoldBlackText),
            ),
          ),
          Card(
            elevation: 2,
            color: Colors.white,
            child: Column(
              children: [
                //Body(),
                // ManageAddressesScreen(),
                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child:
                //  Row(
                //   children: [

                //     Container(
                //       child: Image.network(
                //           "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc1efAN3Ka8-AV1zAI3Y4YIotTQQQiVry7nYXk3anJG7JJEUHu-y5e-dmNaOA8iAScVW8&usqp=CAU",
                //           fit: BoxFit.cover),
                //       height: 60,
                //       width: 100,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 10),
                //       child: Container(
                //         child: Text(
                //           "Phase 5, Sector 59 \nMohali (PB) - 160059",
                //           style: ksmallBlackText,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                //),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Sub Total",
                          style: ksmallBlackText,
                        ),
                      ),
                      Container(
                        child: Text(
                          "\$ " +
                              ScopedModel.of<CartModel>(context,
                                      rebuildOnChange: true)
                                  .totalCartValue
                                  .toString() +
                              "",
                          style: ksmallBlackText,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   child: Text(
                      //     "Shipping Cost",
                      //     style: ksmallBlackText,
                      //   ),
                      // ),
                      // Container(
                      //   child: Text(
                      //     "\$ " +
                      //         ScopedModel.of<CartModel>(context,
                      //                 rebuildOnChange: true)
                      //             .totalCartValue
                      //             .toString() +
                      //         "",
                      //     style: ksmallBlackText,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Total",
                          style: ksmallBlackText,
                        ),
                      ),
                      Container(
                        child: Text(
                          "\$ " +
                              ScopedModel.of<CartModel>(context,
                                      rebuildOnChange: true)
                                  .totalCartValue
                                  .toString() +
                              "",
                          style: ksmallBlackText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  elevation: 8.0,
                  minimumSize: Size(double.infinity,
                      40), // double.infinity is the width and 30 is the height
                ),
                child: Text(
                  "Check Out (" +
                      ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                          .totalCartValue
                          .toString() +
                      ")",
                  style: ksmallText,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Checkout(brandid: brandid)),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CartData extends StatefulWidget {
  final item;

  const CartData({Key key, @required this.item}) : super(key: key);

  @override
  _CartDataState createState() => _CartDataState(item: this.item);
}

class _CartDataState extends State<CartData> {
  final item;
  _CartDataState({this.item});
  @override
  Widget build(BuildContext context) {
    print(widget.item);
    return Card(
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemDetailPage(itemId: item.id)));
                  },
                  child: Container(
                      height: 80,
                      width: 100,
                      margin: EdgeInsets.all(6.0),
                      child: Image.network(
                          Network().imageget + "/" + widget.item.image,
                          fit: BoxFit.cover))),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ItemDetailPage(itemId: item.id)));
                              },
                              child: Container(
                                child: Text(
                                  widget.item.name,
                                  style: kBodyNrmlRedText,
                                ),
                              )),
                          Container(
                              child: Text(
                            widget.item.qty.toString() +
                                " x " +
                                widget.item.price.toString() +
                                " = " +
                                (widget.item.qty *
                                        double.parse(widget.item.price))
                                    .toString(),
                            style: kNavigationText,
                          )),
                          Container(
                            child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          CupertinoIcons.add,
                                          color: Colors.red[800],
                                          size: 14,
                                        ),
                                        onPressed: () {
                                          ScopedModel.of<CartModel>(context,
                                                  rebuildOnChange: true)
                                              .updateProduct(widget.item,
                                                  widget.item.qty + 1);
                                          // model.removeProduct(model.cart[index]);
                                        },
                                      ),
                                      Text("1"),
                                      IconButton(
                                        icon: Icon(
                                          CupertinoIcons.minus,
                                          color: Colors.red[800],
                                          size: 14,
                                        ),
                                        onPressed: () {
                                          ScopedModel.of<CartModel>(context,
                                                  rebuildOnChange: true)
                                              .updateProduct(widget.item,
                                                  widget.item.qty - 1);
                                          // model.removeProduct(model.cart[index]);
                                        },
                                      ),
                                    ])),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
