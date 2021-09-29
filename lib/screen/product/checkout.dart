import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:truck/model/Address.dart';
import 'package:truck/model/cartmodel.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/manage_addresses/components/body.dart';
import 'package:truck/screen/my-globals.dart';

import 'package:truck/screen/product/product_detail.dart';
import 'package:truck/service/database/user_database_helper.dart';

import 'package:flutter/foundation.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:truck/utlis/platte.dart';

class Checkout extends StatefulWidget {
  final int brandid;
  const Checkout({Key key, this.brandid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckoutState(brandid: this.brandid);
  }
}

class _CheckoutState extends State<Checkout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _dropDownValue = new TextEditingController();

  final int brandid;
  _CheckoutState({this.brandid});

  String _destinationAddress = '';
  String _placeDistance;
  String price;
  List getvehicledata;
  static final String tokenizationKey = 'sandbox_cs2jkvwm_mv3frknkgrs3rsxb';
  @override
  void initState() {
    super.initState();
    getvehicle();

    //print("body ${bodydata.addresstextid}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[800]),
        backgroundColor: Colors.white,
        title: Text(
          "Check Out",
          style: kBodyNrmlRedText,
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("Shipping address", style: kNormalBoldBlackText),
            ),
          ),
          Card(
            elevation: 2,
            color: Colors.white,
            child: Column(
              children: [
                //Body(),
                Container(
                  child: Body(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("Select Vehicle Type",
                        style: kNormalBoldBlackText),
                  ),
                ),
                vehicle(),
                if (_placeDistance != null)
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
                if (_placeDistance != null)
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
                            "\$ " + price + "",
                            style: ksmallBlackText,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(
                  height: 10,
                ),
                if (_placeDistance != null)
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
                                (ScopedModel.of<CartModel>(context,
                                                rebuildOnChange: true)
                                            .totalCartValue +
                                        double.parse(price))
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
          if (_placeDistance != null)
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
                        (ScopedModel.of<CartModel>(context,
                                        rebuildOnChange: true)
                                    .totalCartValue +
                                double.parse(price))
                            .toString() +
                        ")",
                    style: ksmallText,
                  ),
                  onPressed: () async {
                    double amount = ScopedModel.of<CartModel>(context,
                                rebuildOnChange: true)
                            .totalCartValue +
                        double.parse(price);
                    //print(amount);
                    payment(amount);
                    // payment(
                    //     ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                    //         .totalCartValue);

                    //  Navigator.push(
                    //    context,
                    //  MaterialPageRoute(builder: (context) => PaymentDetail()),
                    //  );
                  },
                ),
              ),
            )
        ],
      )),
    );
  }

  getvehicle() async {
    var res = await Network().getData('/getvehicle');
    final jsonresponse = json.decode(res.body);

    print(jsonresponse['vehicle']);
    this.setState(() {
      getvehicledata = jsonresponse['vehicle'];
    });
    //print(alertdata);
  }

  Widget vehicle() {
    return SizedBox(
      height: 100.0,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: getvehicledata == null ? 0 : getvehicledata.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _dropDownValue.text = getvehicledata[index]['name'];
                    _calculateDistance();
                    //_dropDownValue.text = getvehicledata[index]['name'];
                  });
                },
                child: Image(
                  image: NetworkImage(Network().imageget +
                      "/" +
                      getvehicledata[index]['image']),
                  height: 200,
                ),
              ),
            );
          }),
    );
  }

  Future<bool> _calculateDistance() async {
    var getadder = await Network().getData('/get_address/$brandid');
    final startaddres = json.decode(getadder.body);
    String _startAddress = startaddres['data'];
    Future<Address> addresdata =
        UserDatabaseHelper().getAddressFromId(globaladdresid);
    addresdata.then((value) {
      _destinationAddress = value.city;
      //print("body $value");
    });

    try {
      print(_destinationAddress);

      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.

      double startLatitude = startPlacemark[0].latitude;
      double startLongitude = startPlacemark[0].longitude;
      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;
      print("data$destinationLongitude");
      double totalDistance = 0.0;
      // Calculating the total distance by adding the distance
      // between small segments

      totalDistance = _coordinateDistance(startLatitude, startLongitude,
          destinationLatitude, destinationLongitude);

      //int ridkm = int.tryParse(totalDistance.toStringAsFixed(2));
      //rint(totalDistance);
      var res = await Network().getData('/get_price/$totalDistance');
      final jsonresponse = json.decode(res.body);
      print("data$jsonresponse");
      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        price = (jsonresponse['price']).toString();
        //print("data $_placeDistance");

        //print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  payment(amount) async {
    var request = BraintreeDropInRequest(
      tokenizationKey: tokenizationKey,
      collectDeviceData: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: amount.toString(),
        currencyCode: 'USD',
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(
        amount: amount.toString(),
        displayName: 'Example company',
      ),
      cardEnabled: true,
    );
    final result = await BraintreeDropIn.start(request);
    if (result != null) {
      //print("dsfsd");
      final resultdata = {
        'nonce': result.paymentMethodNonce.nonce,
        'device_data': result.deviceData,
        "order_number": "543543",
        "client_id": globalInt,
        "price": amount,
        "distanse": _placeDistance
      };
      var res = await Network().authData(resultdata, '/make');
      print(res);
      // var body =
      //     json.decode(
      //         res.body);
      //print(body);
      // if (body['data'][
      //         'success'] ==
      //     true) {
      //print(body['data']);
      // final orderVAlue =
      //     {
      //   "order_number":
      //       alertdata[
      //               index]
      //           [
      //           'order_number'],
      //   "driver_id":
      //       alertdata[
      //               index]
      //           [
      //           'driver_id'],
      //   "client_id":
      //       globals
      //           .globalInt,
      //   "price": alertdata[
      //           index]
      //       ['price'],
      // };

    }
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
    //print(widget.item);
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
