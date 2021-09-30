import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/model/Address.dart';
import 'package:truck/model/cartmodel.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/cart/cart_page.dart';
import 'package:truck/screen/home.dart';
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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final int brandid;
  _CheckoutState({this.brandid});
  String _startAddress;
  String _destinationAddress = '';
  String _placeDistance;
  String price;
  List getvehicledata;
  //firbase online driver
  List alldriver;
  List list = [];
  static final String tokenizationKey = 'sandbox_cs2jkvwm_mv3frknkgrs3rsxb';
  @override
  void initState() {
    super.initState();
    getvehicle();
    getData();

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
                    "Pay (" +
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
                    String result = await payment(amount);
                    if (result == "success") {
                      _alert(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    } else {
                      print("error ");
                    }
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
    Future<Address> addresdata =
        UserDatabaseHelper().getAddressFromId(globaladdresid);
    await addresdata.then((value) {
      _destinationAddress = value.city;
      //print("body $value");
    });
    var getadder = await Network().getData('/get_address/$brandid');
    final startaddres = json.decode(getadder.body);
    _startAddress = startaddres['data'];

    try {
      print(_destinationAddress);
      print(globaladdresid);

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
    Fluttertoast.showToast(msg: 'Please wait order is created');
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
        "client_id": globalInt,
        "client_type": globalRole,
        "price": amount,
        "pickup_location": _startAddress,
        "drop_location": _destinationAddress,
        "distanse": _placeDistance,
        "vehicle_type": _dropDownValue.text,
      };
      var res = await Network().authData(resultdata, '/make');

      var body = json.decode(res.body);
      //print("body$body");
      if (body['data']['success'] == true) {
        var productbody;
        int ordecreater = 0;
        ScopedModel.of<CartModel>(context, rebuildOnChange: true)
            .cart
            .forEach((element) async {
          var data = {
            'product_id': element.id,
            'quatity': element.qty,
            'order_number': body['order_number'],
            'price': element.price,
            'categoryid': element.categoryid,
            'saleprice': element.saleprice,
            'brandid': element.brandid,
            'totalprice': element.saleprice * element.qty,
          };
          var productres =
              await Network().authData(data, "/create_product_order");
          productbody = json.decode(productres.body);

          if (productbody['status'] == 200) {
            ordecreater = 1;
            Fluttertoast.showToast(msg: "Prossesing");
          }
          //print(element.name);
        });
        print(productbody);
        //Fluttertoast.showToast(msg: "Please try again something wronge");
        return allsend(body['order_number']);
        // } else {

        //return "failed";
        //}
      }
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

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Order Created",
      desc: "Your order has been created",
      buttons: [
        // DialogButton(
        //   child: Text(
        //     "BACK",
        //     style: TextStyle(color: Colors.white, fontSize: 20),
        //   ),
        //   onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        //   color: Color.fromRGBO(0, 179, 134, 1.0),
        // ),
        DialogButton(
          child: Text(
            "GO Home",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
            Navigator.of(context, rootNavigator: true).pop();
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
    //debugPrint("Alert closed now.");
  }

  getData() async {
    //return await FirebaseFirestore.instance.collection('DriversList').getDocuments();
    firestore.collection("driver").get().then((querySnapshot) {
      //print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        //Map<String, dynamic> user = result.data();
        list.add(result.data());
        //data = jsonEncode(opAttrList.map((e) => e.toJson()).toList());

        //list.add(result.data().toString());
      });
      this.setState(() {
        alldriver = list;
      });

      //print(data);
    });
  }

  allsend(ordernumber) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = jsonDecode(localStorage.getString('user'));

    alldriver.forEach((index) =>

        //print(element['name'])
        index['vehicle_type'] == _dropDownValue.text
            ? sendNotification("Request Sent To Driver", {
                "token": index['token'],
                "name": index['name'],
                //"recever_id": index['id'],
                "vehicle_type": index['vehicle_type'],
                "mobile_number": index['mobile_number'],
                "image": index['image'],
                "licence": index['licence'],
                "sender_id": user['id'],
                "sender_name": user['name'],
                "order_number": ordernumber,

                "Distance": _placeDistance,
                "price": price,
                "current": _startAddress,
                "drop": _destinationAddress,
                "title": "Arrival365 Order Accept",
                "body": "Accept the booking"
              })
            : null);
    return "success";
  }

  static Future<void> sendNotification(msg, value) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";

    //var token = await getToken(receiver);
    //print('token : $token');

    final data = {
      "notification": {"body": value['body'], "title": value['title']},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "name": value['name'],
        "order_number": value['order_number'],
        "vehicle_type": value['vehicle_type'],
        "mobile_number": value['mobile_number'],
        "image": value['image'],
        "sender_id": value['sender_id'],
        "sender_name": value['sender_name'],
        "Distance": value['Distance'],
        "current": value['current'],
        "drop": value['drop'],
        "deminishons": value['deminishons'],
        "price": value['price'],
        "screen": "messagelist"
      },
      "to": value['token']
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAry0Gih4:APA91bH56uF4N4zvCWsVI7EI4q5ubdKGsbl1ZVY3UVI1-MTLXfBppYFLnWlbN1-wU1snuI8eyi_FphmTz_e-GYnP7zZj_cElC42Ga_4ufw1FlRapetZabFrVK324kS6a-jhUSTYk4nmh'
    };

    BaseOptions options = new BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      final response = await Dio(options).post(postUrl, data: data);
//print('result : $response');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: msg);
        return "success";
      } else {
        print('notification sending failed');
        return "failed";
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
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
