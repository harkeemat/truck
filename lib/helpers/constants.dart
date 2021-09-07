import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_place/google_place.dart';

const GOOGLE_MAPS_API_KEY = "AIzaSyAn1Nr6R43hFECn8R3RtdRcHrhsUJNy7MQ";
const COUNTRY = "india";

final FirebaseFirestore firebaseFiretore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging fcm = FirebaseMessaging.instance;
GooglePlace googlePlace = GooglePlace(GOOGLE_MAPS_API_KEY);
