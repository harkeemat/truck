import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:truck/shop/screens/foodOrder/order_confirm_detail.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

class PaymentDetail extends StatefulWidget {
  PaymentDetail({Key key}) : super(key: key);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
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
          "Payment",
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
      body: ListView(
        primary: false,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text("Card Details", style: kBoldNavigationText),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Container(
                      child: Text(
                        "Card Type",
                        style: ksmallBlackText,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GridView(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          childAspectRatio: 4 / 5,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0),
                      children: [
                        Card(
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/masterCard.png'),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/masterCard.png'),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/masterCard.png'),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/masterCard.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter card holder name",
                    labelStyle: ksmallBlackText,
                    // fillColor: Colors.red,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black45, width: 1.5),
                    ),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black45, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Card number",
                    labelStyle: ksmallBlackText,
                    // fillColor: Colors.red,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black45, width: 1.5),
                    ),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black45, width: 1.5),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Valid Thru",
                          labelStyle: ksmallBlackText,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 1.5),
                          ),
                          alignLabelWithHint: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black45, width: 1.5),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  new Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10, right: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Cvv",
                        labelStyle: ksmallBlackText,
                        // fillColor: Colors.red,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                        ),
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black45, width: 1.5),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ],
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
            padding: const EdgeInsets.all(16.0),
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
                    MaterialPageRoute(builder: (context) => OrderConfirm()),
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
