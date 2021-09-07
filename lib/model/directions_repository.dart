import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truck/model/directions_model.dart';

class DirectionsRepository {
  String googleAPIKey = 'AIzaSyD_jwuI95rMPoKqZ8_jWF8gPgpaYYlN7WQ';
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio dio;

  DirectionsRepository({Dio dio}) : dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    //print("origin $origin");
    //print("distance $destination");
    final response = await dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );
    //print("distance ${response.data}");
    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}
