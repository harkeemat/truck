import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:truck/shop/screens/foodOrder/track_order.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

class OrderConfirm extends StatefulWidget {
  OrderConfirm({Key key}) : super(key: key);

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  get emailController => null;

//int _itemCount = 0;
  String _price = "\$10";
  String _totalPrice = "\$78";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[800]),
        backgroundColor: Colors.white,
        title: Text(
          "Order Confirmation",
          style: kBodyNrmlRedText,
        ),
        leading: IconButton(
            iconSize: 18.0,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              );
            }),
        elevation: 2,
      ),
      body: Padding(
          padding: const EdgeInsets.all(4),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                child: Container(
                  child: Text("Order Confirmation", style: kBoldNavigationText),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 4.0),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    "assets/images/confirm.jpg",
                    color: Colors.red[400],
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Text("Hey Gaurav", style: ksmallBoldBlackText),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 4.0),
                  child: Container(
                    child: Text("Thanks for your purchase",
                        style: ksmallBlackText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
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
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black,
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TrackOrder()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 8.0,
                          // minimumSize: Size(double.infinity,
                          //     40),
                        ),
                        child: Text(
                          "Track your order",
                          style: TextStyle(color: Colors.red),
                        )),
                  ),
                  Container(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 8.0,
                          // minimumSize: Size(double.infinity,
                          //     40),
                        ),
                        child: Text(
                          "Home",
                        )),
                  )
                ],
              )
            ],
          )),
    );
  }
}
