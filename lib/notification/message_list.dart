// @dart=2.9

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/test.dart';

// import 'package:truck/screen/test.dart';
//
/// Listens for incoming foreground messages and displays them in a list.
class MessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<RemoteMessage> _messages = [];
  List messagedta;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _discriptionController =
      new TextEditingController();

  int number = 1;
  bool noti = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      //print("globallist$globallist");
      if (globallist != null) {
        _messages = globallist;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        //print("listen $message");
        //globallist = [..._messages, message];
        _messages = [..._messages, message];
        //setnotificationdata(_messages);
      });
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage message) {
        setState(() {
          //print("getInitialMessage $message");
          globallist = [..._messages, message];
          _messages = [..._messages, message];
          //setnotificationdata(_messages);
        });
        // Navigator.pushNamed(context, "/" + message.data['screen'],
        // arguments: MessageArguments(message, true));
      });

      //print("dssd$noti");
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (_messages.isEmpty) {
      return const Text('No messages received');
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length != null ? _messages.length : 0,
        // ignore: missing_return
        itemBuilder: (context, index) {
          RemoteMessage message = _messages[index];

          if (message != null) print("list${message.data}");
          return Container(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: globalColor,
                  elevation: 30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                    "Client name=> ${message.data['sender_name']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12))),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Order No # ${message.data['order_number']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Pick Up Loaction=> ${message.data['current']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Drop Location=> ${message.data['drop']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Pick Up Date=> ${message.data['date']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Drop Date=> ${message.data['dropdate']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Luggage Type=> ${message.data['luggage']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Deminishons=> ${message.data['deminishons']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  "Total Distance=> ${message.data['Distance']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("Price=> ${message.data['price']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text("Weight=> ${message.data['Weight']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: TextField(
                          controller: _priceController,
                          decoration: InputDecoration(
                            hintText: 'Price',
                          ),
                          // onSubmitted: (value) {
                          // getData();
                          // },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: TextField(
                          controller: _discriptionController,
                          decoration: InputDecoration(
                            hintText: 'Discription',
                          ),
                          // onSubmitted: (value) {
                          // getData();
                          // },
                        ),
                      ),
                      Center(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                  FlatButton(
                                    onPressed: () {}, child: Text("Cancel")),
                                FlatButton(
                                    onPressed: () {
                                      _response(message.data);
                                    },
                                    child: Text("Aprrove")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      // height: 600.0,
                      // child: Padding(
                      // padding: EdgeInsets.all(0),
                      // child: Test(currentdata: {
                      // "currentLocation": message.data['current'],
                      // "destinationLocation": message.data['drop']
                      // }),
                      // ),
                      // ),
                    ],
                    ),
                ),
              ],
            ),
          );
        });
  }

  void _response(user) async {
    //print("fsfdsf$user");
    String sender_id = (user['sender_id']).toString();
    //String recever_id = (globalInt).toString();

    await firestore
        .collection((user['sender_id']).toString())
        .doc((globalInt).toString())
        .set({
      'driver_id': globalInt,
      'price': _priceController.text,
      'discription': _discriptionController.text,
      'vehicle_type': user['vehicle_type'],
      'order_number': user['order_number'],
      'mobile_number': user['mobile_number'],
      'name': user['name'],
    });
  }
}

class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Text(_title != null ? _title : "defulte",
                          style: const TextStyle(fontSize: 18))),
                  _children,
                ]))));
  }
}

// class AppSizes {
//   static const int splashScreenTitleFontSize = 48;
//   static const int titleFontSize = 34;
//   static const double sidePadding = 15;
//   static const double widgetSidePadding = 20;
//   static const double buttonRadius = 25;
//   static const double imageRadius = 8;
//   static const double linePadding = 4;
//   static const double widgetBorderRadius = 34;
//   static const double textFieldRadius = 4.0;
//   static const EdgeInsets bottomSheetPadding =
//       EdgeInsets.symmetric(horizontal: 16, vertical: 10);
//   static const app_bar_size = 56.0;
//   static const app_bar_expanded_size = 180.0;
//   static const tile_width = 148.0;
//   static const tile_height = 276.0;
// }

// class AppColors {
//   static const red = Color(0xFFDB3022);
//   static const black = Color(0xFF222222);
//   static const lightGray = Color(0xFF9B9B9B);
//   static const darkGray = Color(0xFF979797);
//   static const white = Color(0xFFFFFFFF);
//   static const orange = Color(0xFFFFBA49);
//   static const background = Color(0xFFE5E5E5);
//   static const backgroundLight = Color(0xFFF9F9F9);
//   static const transparent = Color(0x00000000);
//   static const success = Color(0xFF2AA952);
//   static const green = Color(0xFF2AA952);
// }

// class AppConsts {
//   static const page_size = 20;
// }

// Ref: Font Weights: https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html
// Ref: Font Weights for TextTheme: https://api.flutter.dev/flutter/material/TextTheme-class.html
// class OpenFlutterEcommerceTheme {
//   static ThemeData of(context) {
//     var theme = Theme.of(context);
//     return theme.copyWith(
//       primaryColor: AppColors.black,
//       primaryColorLight: AppColors.lightGray,
//       accentColor: AppColors.red,
//       bottomAppBarColor: AppColors.lightGray,
//       backgroundColor: AppColors.background,
//       dialogBackgroundColor: AppColors.backgroundLight,
//       errorColor: AppColors.red,
//       dividerColor: Colors.transparent,
//       appBarTheme: theme.appBarTheme.copyWith(
//           color: AppColors.white,
//           iconTheme: IconThemeData(color: AppColors.black),
//           textTheme: theme.textTheme.copyWith(
//               caption: TextStyle(
//                   color: AppColors.black,
//                   fontSize: 18,
//                   fontFamily: 'Metropolis',
//                   fontWeight: FontWeight.w400))),
//       textTheme: theme.textTheme
//           .copyWith(
//             //over image white text
//             headline: theme.textTheme.headline.copyWith(
//                 fontSize: 48,
//                 color: AppColors.white,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w900),
//             title: theme.textTheme.title.copyWith(
//                 fontSize: 24,
//                 color: AppColors.black,
//                 fontWeight: FontWeight.w900,
//                 fontFamily: 'Metropolis'), //

//             //product title
//             display1: theme.textTheme.display1.copyWith(
//                 color: AppColors.black,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'Metropolis'),

//             display2: theme.textTheme.display2.copyWith(
//                 fontFamily: 'Metropolis', fontWeight: FontWeight.w400),
//             //product price
//             display3: theme.textTheme.display3.copyWith(
//                 color: AppColors.lightGray,
//                 fontSize: 14,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400),
//             display4: theme.textTheme.display4.copyWith(
//                 fontFamily: 'Metropolis', fontWeight: FontWeight.w500),

//             subtitle: theme.textTheme.headline.copyWith(
//                 fontSize: 18,
//                 color: AppColors.black,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400),
//             subhead: theme.textTheme.headline.copyWith(
//                 fontSize: 24,
//                 color: AppColors.darkGray,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w500),
//             //red button with white text
//             button: theme.textTheme.button.copyWith(
//                 fontSize: 14,
//                 color: AppColors.white,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w500),
//             //black caption title
//             caption: theme.textTheme.caption.copyWith(
//                 fontSize: 34,
//                 color: AppColors.black,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w700),
//             //light gray small text
//             body1: theme.textTheme.body1.copyWith(
//                 color: AppColors.lightGray,
//                 fontSize: 11,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400),
//             //view all link
//             body2: theme.textTheme.body2.copyWith(
//                 color: AppColors.black,
//                 fontSize: 11,
//                 fontFamily: 'Metropolis',
//                 fontWeight: FontWeight.w400),
//           )
//           .apply(fontFamily: 'Metropolis'),
//       buttonTheme: theme.buttonTheme.copyWith(
//         minWidth: 50,
//         buttonColor: AppColors.red,
//       ),
//     );
//   }
//}
