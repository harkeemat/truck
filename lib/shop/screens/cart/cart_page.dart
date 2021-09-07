import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:truck/shop/screens/cart/cart_model.dart';
import 'package:truck/shop/screens/payment/payment_detail.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String _price = "\$10";
  String _totalPrice = "\$78";

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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 18.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              );
            }),
        elevation: 2,
      ),
      body: ListView(
        children: [
          Container(
            child: (CartModel.products.isNotEmpty)
                ? ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    itemCount: CartModel.products.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CartData(item: CartModel.products[index]))
                : CircularProgressIndicator(),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc1efAN3Ka8-AV1zAI3Y4YIotTQQQiVry7nYXk3anJG7JJEUHu-y5e-dmNaOA8iAScVW8&usqp=CAU",
                            fit: BoxFit.cover),
                        height: 60,
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          child: Text(
                            "Phase 5, Sector 59 \nMohali (PB) - 160059",
                            style: ksmallBlackText,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                          "\$68",
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
                      Container(
                        child: Text(
                          "Shipping Cost",
                          style: ksmallBlackText,
                        ),
                      ),
                      Container(
                        child: Text(
                          "+$_price",
                          style: ksmallBlackText,
                        ),
                      ),
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
                          "$_totalPrice",
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
                  "MAKE ORDER ($_totalPrice)",
                  style: ksmallText,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentDetail()),
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

class CartData extends StatelessWidget {
  final CartItem item;

  const CartData({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Container(
                  height: 80,
                  width: 100,
                  margin: EdgeInsets.all(6.0),
                  child: Image.network(item.image, fit: BoxFit.cover)),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              item.name,
                              style: kBodyNrmlRedText,
                            ),
                          ),
                          Container(
                            child: Text(
                              "Desert sweet icecream",
                              style: kNavigationText,
                            ),
                          ),
                          Container(
                            child: Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(6, 2.0, 6.0, 2.0),
                                      child: Icon(
                                        CupertinoIcons.add,
                                        color: Colors.red[800],
                                        size: 14,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10, 2.0, 6.0, 2.0),
                                      child: Text(
                                        "1",
                                        style: kBodyNrmlRedText,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          10, 2.0, 6.0, 2.0),
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.red[800],
                                        size: 14,
                                      )),
                                ],
                              ),
                            ),
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
