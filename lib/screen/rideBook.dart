import 'dart:async';

import 'dart:math' show Random, asin, cos, sqrt;
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/getdetail.dart';

import 'package:truck/screen/my-globals.dart';

import 'package:truck/screen/nav-drawer.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truck/notification/message_list.dart';
import 'package:truck/screen/my-globals.dart' as globals;
import 'package:truck/screen/startride.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(29.3219, -71.167889);
const LatLng DEST_LOCATION = LatLng(30.733315, 76.779419);

class RideBook extends StatefulWidget {
  RideBook({Key key}) : super(key: key);

  @override
  _RideBookState createState() => _RideBookState();
}

class _RideBookState extends State<RideBook> {
  //map

  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //final Firestore _db = Firestore.instance;

  final TextEditingController _currentController = new TextEditingController();
  final TextEditingController _dropController = new TextEditingController();
  final TextEditingController _luggageController = new TextEditingController();
  final TextEditingController _WeightController = new TextEditingController();
  final TextEditingController _dropDownValue = new TextEditingController();
  final TextEditingController _deminishonsController =
      new TextEditingController();
  final TextEditingController _tokenController = new TextEditingController();
  final dateController = new TextEditingController();
  final dropController = new TextEditingController();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static final String tokenizationKey = 'sandbox_cs2jkvwm_mv3frknkgrs3rsxb';
  String isDriver;

  bool isAuth = false;
  bool isOn = false;
  bool respose = false;
  int order_number;

  // random(min, max) {
  // var rn = new Random();
  // return min + rn.nextInt(max - min);
  // }

  static Future<void> sendNotification(receiver, msg, value) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";

    var token = await getToken(receiver);
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
        "luggage": value['luggage'],
        "Distance": value['Distance'],
        "date": value['date'],
        "current": value['current'],
        "drop": value['drop'],
        "dropdate": value['dropdate'],
        "deminishons": value['deminishons'],
        "licence": value['licence'],
        "Weight": value['Weight'],
        "price": value['price'],
        "screen": "ridebook"
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
        Fluttertoast.showToast(msg: 'Request Sent To Driver');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      print('exception $e');
    }
  }

  static Future<String> getToken(userId) async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    var token;
    String fcmToken = await _fcm.getToken();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId.toString())
        .collection('tokens')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        token = doc.id;
      });
    });

    return fcmToken;
  }

  double bearing;
  int km;
  List data;
  List list = [];
  List alertdata;
  List alert = [];
  String price;
  Future<String> getData() async {
    //return await FirebaseFirestore.instance.collection('DriversList').getDocuments();
    firestore.collection("users").get().then((querySnapshot) {
      //print(querySnapshot.docs);
      querySnapshot.docs.forEach((result) {
        //Map<String, dynamic> user = result.data();
        list.add(result.data());
        //data = jsonEncode(opAttrList.map((e) => e.toJson()).toList());

        //list.add(result.data().toString());
      });
      this.setState(() {
        data = list;
        isOn = true;
      });

      //print(data);
    });
  }

  // Future<User> getuserid(id) async {
  // var res = await Network().getData('/get_user/$id');
  //print("fsfdfsd $res");
  // final jsonresponse = json.decode(res.body);

  //

  // return User.fromJson(jsonresponse['data'][0]);
  // }

  void lcation() async {
    //print(_currentController.text);
    List<Location> Cunrretlocations = await locationFromAddress(_startAddress);
    List<Location> droplocations =
        await locationFromAddress(_destinationAddress);

    // setState(() {
    // double distanceInMeters = (Geolocator.distanceBetween(
    // Cunrretlocations.single.latitude,
    // Cunrretlocations.single.longitude,
    // droplocations.single.latitude,
    // droplocations.single.longitude)) /
    // 1000;
    // bearing = Geolocator.bearingBetween(
    // Cunrretlocations.single.latitude,
    // Cunrretlocations.single.longitude,
    // droplocations.single.latitude,
    // droplocations.single.longitude);
    // isAuth = true;
    // km = distanceInMeters.toInt();
    // });

    try {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {});
      }).catchError((e) {
        print(e);
      });

      //print(isAuth);

    } catch (e) {
      print(e);
    }
  }

  List getvehicledata;
  getvehicle() async {
    var res = await Network().getData('/getvehicle');
    final jsonresponse = json.decode(res.body);

    print(jsonresponse['vehicle']);
    this.setState(() {
      getvehicledata = jsonresponse['vehicle'];
    });
    //print(alertdata);
  }

  @override
  void initState() {
    super.initState();
    //delete();
    getvehicle();
    //timer = Timer.periodic(Duration(seconds: 45), (Timer t) => get_approve());
    _getCurrentLocation();
    //getuserid(27);
    //order_number = random(100, 999999);
    //print(order_number);
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');

//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    //print(user);
    setState(() {
      isDriver = user['role'];
    });
  }

  Timer timer;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //get_approve();

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: globalColor,
        title: Text("Book Ride"),
      ),
      body: Padding(
          padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Container(
              child: isDriver == "driver"
                  ? Column(
                      children: [
                        MetaCard('Ride Accept', MessageList()),
                      ],
                    )
                  : respose == false
                      ? Column(children: <Widget>[
                          Container(
                            height: height,
                            width: width,
                            child: Scaffold(
                              key: _scaffoldKey,
                              body: Stack(
                                children: <Widget>[
                                  // Map View
                                  GoogleMap(
                                    markers: Set<Marker>.from(markers),
                                    initialCameraPosition: _initialLocation,
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: false,
                                    mapType: MapType.normal,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    polylines:
                                        Set<Polyline>.of(polylines.values),
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      mapController = controller;
                                    },
                                  ),
                                  // Show zoom buttons
                                  SafeArea(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          ClipOval(
                                            child: Material(
                                              color: Colors.blue
                                                  .shade100, // button color
                                              child: InkWell(
                                                splashColor: Colors
                                                    .blue, // inkwell color
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Icon(Icons.add),
                                                ),
                                                onTap: () {
                                                  mapController.animateCamera(
                                                    CameraUpdate.zoomIn(),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          ClipOval(
                                            child: Material(
                                              color: Colors.blue
                                                  .shade100, // button color
                                              child: InkWell(
                                                splashColor: Colors
                                                    .blue, // inkwell color
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: Icon(Icons.remove),
                                                ),
                                                onTap: () {
                                                  mapController.animateCamera(
                                                    CameraUpdate.zoomOut(),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Show the place input fields & button for
                                  // showing the route
                                  SafeArea(
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.0),
                                            ),
                                          ),
                                          width: width * 0.9,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  'Places',
                                                  style:
                                                      TextStyle(fontSize: 20.0),
                                                ),
                                                SizedBox(height: 10),
                                                _textField(
                                                    label: 'Start',
                                                    hint:
                                                        'Choose starting point',
                                                    prefixIcon:
                                                        Icon(Icons.looks_one),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                          Icons.my_location),
                                                      onPressed: () {
                                                        startAddressController
                                                                .text =
                                                            _currentAddress;
                                                        _startAddress =
                                                            _currentAddress;
                                                      },
                                                    ),
                                                    controller:
                                                        startAddressController,
                                                    focusNode:
                                                        startAddressFocusNode,
                                                    width: width,
                                                    locationCallback:
                                                        (String value) {
                                                      setState(() {
                                                        _startAddress = value;
                                                      });
                                                    }),
                                                SizedBox(height: 10),
                                                _textField(
                                                    label: 'Destination',
                                                    hint: 'Choose destination',
                                                    prefixIcon:
                                                        Icon(Icons.looks_two),
                                                    controller:
                                                        destinationAddressController,
                                                    focusNode:
                                                        desrinationAddressFocusNode,
                                                    width: width,
                                                    locationCallback:
                                                        (String value) {
                                                      setState(() {
                                                        _destinationAddress =
                                                            value;
                                                      });
                                                    }),
                                                SizedBox(height: 10),
                                                Visibility(
                                                  visible:
                                                      _placeDistance == null
                                                          ? false
                                                          : true,
                                                  child: Text(
                                                    'DISTANCE: $_placeDistance km,And Price $price.',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                ElevatedButton(
                                                  onPressed: (_startAddress !=
                                                              '' &&
                                                          _destinationAddress !=
                                                              '')
                                                      ? () async {
                                                          startAddressFocusNode
                                                              .unfocus();
                                                          desrinationAddressFocusNode
                                                              .unfocus();
                                                          setState(() {
                                                            if (markers
                                                                .isNotEmpty)
                                                              markers.clear();
                                                            if (polylines
                                                                .isNotEmpty)
                                                              polylines.clear();
                                                            if (polylineCoordinates
                                                                .isNotEmpty)
                                                              polylineCoordinates
                                                                  .clear();
                                                            _placeDistance =
                                                                null;
                                                          });
                                                          _calculateDistance()
                                                              .then(
                                                                  (isCalculated) {
                                                            if (isCalculated) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Distance Calculated Sucessfully'),
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'Error Calculating Distance'),
                                                                ),
                                                              );
                                                            }
                                                          });
                                                          //lcation();
                                                        }
                                                      : null,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Show Route'
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Show current location button
                                  SafeArea(
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, bottom: 10.0),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.orange
                                                .shade100, // button color
                                            child: InkWell(
                                              splashColor: Colors
                                                  .orange, // inkwell color
                                              child: SizedBox(
                                                width: 56,
                                                height: 56,
                                                child: Icon(Icons.my_location),
                                              ),
                                              onTap: () {
                                                mapController.animateCamera(
                                                  CameraUpdate
                                                      .newCameraPosition(
                                                    CameraPosition(
                                                      target: LatLng(
                                                        _currentPosition
                                                            .latitude,
                                                        _currentPosition
                                                            .longitude,
                                                      ),
                                                      zoom: 18.0,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          // padding: EdgeInsets.all(2),
                          // child: TextField(
                          // controller: _currentController,
                          // decoration: InputDecoration(
                          // hintText: 'Current location',
                          // ),
                          // ),
                          // ),
                          // Padding(
                          // padding: EdgeInsets.all(2),
                          // child: TextField(
                          // controller: _dropController,
                          // decoration: InputDecoration(
                          // hintText: 'Drop location',
                          // ),
                          // onSubmitted: (value) {
                          // lcation();
                          // },
                          // ),
                          // ),
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: _placeDistance != null ? fields() : Center(),
                          )
                        ])
                      : Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Column(
                                children: [
                                  alertdata != null
                                      ? new ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: alertdata == null
                                              ? 0
                                              : alertdata.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            //print(alertdata[index]);

                                            return Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                color: Colors.blueGrey,
                                                elevation: 10,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 7,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      "Name : ${alertdata[index]['name']}"),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      "Price : ${alertdata[index]['price']}"),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          1.0,
                                                                          2.0,
                                                                          3.0,
                                                                          4.0),
                                                              child: Text(
                                                                  "Discription :${alertdata[index]['discription']}"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: RaisedButton(
                                                          child:
                                                              Text("Approve"),
                                                          color: Colors.green,
                                                          textColor:
                                                              Colors.yellow,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20),
                                                          splashColor:
                                                              Colors.grey,
                                                          onPressed: () async {
                                                            var request =
                                                                BraintreeDropInRequest(
                                                              tokenizationKey:
                                                                  tokenizationKey,
                                                              collectDeviceData:
                                                                  true,
                                                              googlePaymentRequest:
                                                                  BraintreeGooglePaymentRequest(
                                                                totalPrice:
                                                                    alertdata[
                                                                            index]
                                                                        [
                                                                        'price'],
                                                                currencyCode:
                                                                    'USD',
                                                                billingAddressRequired:
                                                                    false,
                                                              ),
                                                              paypalRequest:
                                                                  BraintreePayPalRequest(
                                                                amount: alertdata[
                                                                        index]
                                                                    ['price'],
                                                                displayName:
                                                                    'Example company',
                                                              ),
                                                              cardEnabled: true,
                                                            );
                                                            final result =
                                                                await BraintreeDropIn
                                                                    .start(
                                                                        request);
                                                            if (result !=
                                                                null) {
                                                              //print("dsfsd");
                                                              final resultdata =
                                                                  {
                                                                'nonce': result
                                                                    .paymentMethodNonce
                                                                    .nonce,
                                                                'device_data':
                                                                    result
                                                                        .deviceData,
                                                                "order_number":
                                                                    alertdata[
                                                                            index]
                                                                        [
                                                                        'order_number'],
                                                                "driver_id":
                                                                    alertdata[
                                                                            index]
                                                                        [
                                                                        'driver_id'],
                                                                "client_id":
                                                                    globals
                                                                        .globalInt,
                                                                "price": alertdata[
                                                                        index]
                                                                    ['price'],
                                                              };
                                                              var res = await Network()
                                                                  .authData(
                                                                      resultdata,
                                                                      '/make');
                                                              var body =
                                                                  json.decode(
                                                                      res.body);
                                                              //print(body);
                                                              if (body['data'][
                                                                      'success'] ==
                                                                  true) {
                                                                //print(body['data']);
                                                                final orderVAlue =
                                                                    {
                                                                  "order_number":
                                                                      alertdata[
                                                                              index]
                                                                          [
                                                                          'order_number'],
                                                                  "driver_id":
                                                                      alertdata[
                                                                              index]
                                                                          [
                                                                          'driver_id'],
                                                                  "client_id":
                                                                      globals
                                                                          .globalInt,
                                                                  "price": alertdata[
                                                                          index]
                                                                      ['price'],
                                                                };
                                                                BookOrder(
                                                                    orderVAlue);
                                                              }
                                                              //print("body$body");

                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                          })
                                      : Center(
                                          child: CircularProgressIndicator()),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
          )),
    );
  }

  Widget fields() {
    return Positioned(
        bottom: 100,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: TextField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(hintText: 'Pick Date'),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  dateController.text = date.toString().substring(0, 10);
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: TextField(
                readOnly: true,
                controller: dropController,
                decoration: InputDecoration(hintText: 'Drop Date'),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  dropController.text = date.toString().substring(0, 10);
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: TextField(
                controller: _WeightController,
                decoration: InputDecoration(
                  hintText: 'Weight',
                ),
                // onSubmitted: (value) {
                // },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: TextField(
                controller: _deminishonsController,
                decoration: InputDecoration(
                  hintText: 'Deminishons',
                ),
                // onSubmitted: (value) {
                // },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: TextField(
                controller: _luggageController,
                decoration: InputDecoration(
                  hintText: 'luggage type',
                ),
                // onSubmitted: (value) {
                // },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
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
                            //_dropDownValue.text = getvehicledata[index]['name'];
                          });
                        },
                        child: Image(
                          image: NetworkImage(Network().imageget +
                              "/" +
                              getvehicledata[index]['image']),
                          height: 200,
                        ),
                        // CircleAvatar(
                        // backgroundImage: NetworkImage(
                        // Network().imageget +
                        // "/" +
                        // alertdata[index]['image']),
                        // radius: 100,
                        // child: ClipOval(
                        // child: Image(
                        // image: NetworkImage(Network().imageget +
                        // "/" +
                        // alertdata[index]['image'])),
                        // ),
                        // ),
                      ),
                    );
                  }),
            ),
            // SizedBox(
            // height: 100.0,
            // child: ListView.builder(
            // physics: ClampingScrollPhysics(),
            // shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            // itemCount: 4,
            // itemBuilder: (BuildContext context, int index) => Card(
            // child: InkWell(
            // onTap: () {
            // setState(() {
            // _dropDownValue.text = "Truck";
            // });
            // },
            // child: CircleAvatar(
            // radius: 70,
            // child: ClipOval(
            // child: Image.asset(
            // 'assets/images/logo.png',
            // height: 100,
            // width: 100,
            // fit: BoxFit.cover,
            // ),
            // ),
            // ),
            // ),
            // ),
            // ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
              child: TextFormField(
                style: TextStyle(color: Color(0xFF000000)),
                cursorColor: Colors.white,
                readOnly: true,
                controller: _dropDownValue,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  hintText: "Vehicle Type",
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    'Book Ride Now',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                color: Colors.teal,
                disabledColor: Colors.grey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () async {
                  //order_number = 54353;
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  final user = jsonDecode(localStorage.getString('user'));
                  final sendValue = {
                    "sender_id": user['id'],
                    "sender_name": user['name'],
                    "luggage": _luggageController.text,
                    "deminishons": _deminishonsController.text,
                    "Weight": _WeightController.text,
                    "dropdate": dropController.text,
                    "Distance": _placeDistance,
                    "date": dateController.text,
                    "current": _startAddress,
                    "drop": _destinationAddress,
                    "vehicle_type": _dropDownValue.text,
                    "title": "Click to Ride Book",
                    "body": "Accept the booking"
                  };
                  sumitorder(sendValue);
                  if (data != null) {
                    data.clear();
                  }

                  getData();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  isOn == true
                      ? Card(
                          color: Colors.grey[800],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Wrap(
                              spacing: 8.0, // gap between adjacent chips
                              runSpacing: 4.0, // gap between lines
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Text(
                                  "Click to send all driver notification",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    allsend();
                                    timer = Timer.periodic(
                                        Duration(seconds: 45),
                                        (Timer t) => get_approve());
                                  },
                                  child: Text('Send',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                )
                              ],
                            ),
                          ),
                        )
                      : Center(),
                  data != null
                      ? new ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data == null ? 0 : data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //print(data[index]);
                            return _dropDownValue.text ==
                                    data[index]['vehicle_type']
                                ? personDetailCard(data[index])
                                : Center();
                          },
                        )
                      : Center(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget personDetailCard(Person) {
    //print("sdsds $Person");
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            direction: Axis.horizontal,
            children: <Widget>[
              InkWell(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Getdetail(id: Person['id'])))
                  //,
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: Person['image'] == null
                                  ? AssetImage("assets/images/logo2.png")
                                  : NetworkImage(Network().imageget +
                                      "/" +
                                      Person['image'])))),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Person['name'],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    Person['snn'],
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  RatingBarIndicator(
                    rating: 2.75,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();
                    final user = jsonDecode(localStorage.getString('user'));
                    final sendValue = {
                      "token": Person['token'],
                      "name": Person['name'],
                      "vehicle_type": Person['vehicle_type'],
                      "mobile_number": Person['mobile_number'],
                      "image": Person['image'],
                      "order_number": order_number,
                      "licence": Person['licence'],
                      "sender_id": user['id'],
                      "sender_name": user['name'],
                      "luggage": _luggageController.text,
                      "deminishons": _deminishonsController.text,
                      "Weight": _WeightController.text,
                      "dropdate": dropController.text,
                      "Distance": _placeDistance,
                      "date": dateController.text,
                      "current": _startAddress,
                      "drop": _destinationAddress,
                      "title": "Click to Ride Book",
                      "body": "Accept the booking"
                    };
                    sendNotification(21, "how are you", sendValue);
                    // timer = Timer.periodic(
                    // Duration(seconds: 45), (Timer t) => get_approve());
                    //Future.delayed(const Duration(seconds: 120));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Send',
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sumitorder(value) async {
    //print(value);
    var res = await Network().authData(value, '/make_order');
    var body = json.decode(res.body);
    Map<String, dynamic> user = body['userData'];
    //print(body);
    if (res.statusCode == 201) {
      order_number = body['data'];
      //print(body['userData']);
    } else {
      order_number = null;
    }
  }

  void delete() async {
    firestore.collection((globals.globalInt).toString()).doc().delete();
    // var collection =
    // FirebaseFirestore.instance.collection((globals.globalInt).toString());
    // var snapshots = await collection.get();
    // for (var doc in snapshots.docs) {
    // await doc.reference.delete();
    // }
  }

  void allsend() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final user = jsonDecode(localStorage.getString('user'));

    data.forEach((index) =>

        //print(element['name'])
        index['vehicle_type'] == _dropDownValue.text
            ? sendNotification(21, "Get Ride Now", {
                "token": index['token'],
                "name": index['name'],
                //"recever_id": index['id'],
                "vehicle_type": index['vehicle_type'],
                "mobile_number": index['mobile_number'],
                "image": index['image'],
                "licence": index['licence'],
                "sender_id": user['id'],
                "sender_name": user['name'],
                "order_number": order_number,
                "luggage": _luggageController.text,
                "deminishons": _deminishonsController.text,
                "Weight": _WeightController.text,
                "dropdate": dropController.text,
                "Distance": _placeDistance,
                "date": dateController.text,
                "current": _currentController.text,
                "drop": _destinationAddress,
                "title": "Click to Ride Book",
                "body": "Accept the booking"
              })
            : null);
  }

  void BookOrder(value) async {
    //print(value);
    var res = await Network().authData(value, '/book_order');
    var body = json.decode(res.body);

    //print(body);
    if (res.statusCode == 201) {
      //print("bodyyy$body");
      //firestore.collection((globals.globalInt).toString()).doc().delete();
      var collection =
          FirebaseFirestore.instance.collection((globals.globalInt).toString());
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
      firestore.collection((globals.globalInt).toString()).doc().delete();
      if (alertdata != null) {
        alertdata.clear();
      }

      //print(body['userData']);

      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => RideBook()),
      );
    }
  }

  Future<String> get_approve() async {
    if (alertdata != null) {
      alertdata.clear();
    }

    //Future.delayed(const Duration(seconds: 120));
    firestore
        .collection((globals.globalInt).toString())
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        alert.add(result.data());
      });
      this.setState(() {
        alertdata = alert;
        if (alertdata == null) {
          respose = false;
        } else {
          respose = true;
        }
      });
      //print(respose);
      //print(alertdata.length);
    });
    // return alertdata.length;
  }

  ///map view
  CameraPosition _initialLocation =
  CameraPosition(target: LatLng(30.699837, 76.768341));
  GoogleMapController mapController;
  Position _currentPosition;
  String _currentAddress = '';
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();
  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;
  Set<Marker> markers = {};
  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _textField({
    TextEditingController controller,
    FocusNode focusNode,
    String label,
    String hint,
    double width,
    Icon prefixIcon,
    Widget suffixIcon,
    Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        //print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
            "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(_destinationAddress);
      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;
      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;
      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;
      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';
      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );
      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;
      double southWestLatitude = miny;
      double southWestLongitude = minx;
      double northEastLatitude = maxy;
      double northEastLongitude = maxx;
      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );
      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );
      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);
      double totalDistance = 0.0;
      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }
      //int ridkm = int.tryParse(totalDistance.toStringAsFixed(2));
      //print("sdsdsa");
      var res = await Network().getData('/get_price/$totalDistance');
      final jsonresponse = json.decode(res.body);
      print("data$jsonresponse");
      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        price = (jsonresponse['price']).toString();
        print("data $price");

        //print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
  }
}
