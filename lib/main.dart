import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:truck/model/cartmodel.dart';

import 'package:truck/model/loaction_model.dart';
import 'package:truck/notification/pushNotification.dart';
import 'package:truck/screen/login.dart';
import 'package:truck/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:truck/notification/message.dart';
import 'package:truck/screen/maps/flutter_google_place_autocomplete.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/product/product_detail.dart';
import 'package:truck/screen/rideBook.dart';
import 'package:truck/screen/my-globals.dart' as globals;
import 'package:truck/service/location_service.dart';

import 'package:provider/provider.dart';




//void main() => runApp(MyApp());
//when app is terminate then work
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  globallist = [...globallist, message];
  

}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  // return runApp(MultiProvider(
  // providers: [
  // ChangeNotifierProvider.value(
  // value: AppState(),
  // )
  // ],
  // child: MyApp(),
  // ));

  runApp(MyApp(
    model: CartModel(),
  ));
}

class MyApp extends StatelessWidget {
   final CartModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartModel>(
        model: model,
        child: MaterialApp(
        title: 'Truck App',
        debugShowCheckedModeBanner: false,
        home: CheckAuth(),
        routes: <String, WidgetBuilder>{
          '/message': (context) => MessageView(),
          "/ridebook": (BuildContext context) => new RideBook(),
          
        }));
  }
}

class CheckAuth extends StatefulWidget {
 
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  
  FirebaseNotifcation firebase;
  //final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // int _messageCount = 0;
  // String _token;

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }

  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      //print("how too $message");
      if (message != null) {
        Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));
         Navigator.pushNamed(context, "/" + message.data['screen'],
            arguments: MessageArguments(message, true));
      }
    });

    ///forgroung work
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //print('onMessageOpenedApp data: ${message.data}');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
      globallist = [...globallist, message];
      Navigator.pushNamed(context, "/" + message.data['screen'],
          arguments: MessageArguments(message, true));
    });
//when app is in background but opend and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('A new onMessageOpenedApp event was published! $message');

       Navigator.pushNamed(context, "/" + message.data['screen'],
          arguments: MessageArguments(message, true));
    });
    firebase = FirebaseNotifcation();
    handleAsync();
  }

  //notification
  //FirebaseNotifcation firebase;

  handleAsync() async {
    await firebase.initialize();

    //String token = await firebase.getToken();
    //print("Firebase token : $token");
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //print('first token : $token');
    if (token != null) {
      var user = jsonDecode(localStorage.getString('user'));
      setState(() {
        isAuth = true;
        globals.globalString = user['role'];
        globals.globalInt = user['id'];
      });
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Cloud Messaging'),
  //       actions: <Widget>[
  //         PopupMenuButton(
  //           onSelected: onActionSelected,
  //           itemBuilder: (BuildContext context) {
  //             return [
  //               const PopupMenuItem(
  //                 value: 'subscribe',
  //                 child: Text('Subscribe to topic'),
  //               ),
  //               const PopupMenuItem(
  //                 value: 'unsubscribe',
  //                 child: Text('Unsubscribe to topic'),
  //               ),
  //               const PopupMenuItem(
  //                 value: 'get_apns_token',
  //                 child: Text('Get APNs token (Apple only)'),
  //               ),
  //             ];
  //           },
  //         ),
  //       ],
  //     ),

  //     body: SingleChildScrollView(
  //       child: Column(children: [
  //         MetaCard('Permissions', Permissions()),
  //         MetaCard('FCM Token', TokenMonitor((token) {
  //           _token = token;
  //           return token == null
  //               ? const CircularProgressIndicator()
  //               : Text(token, style: const TextStyle(fontSize: 12));
  //         })),
  //         MetaCard('Message Stream', MessageList()),
  //       ]),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: isAuth ? Home() : Login(),
      ),
    );
  }
}






















