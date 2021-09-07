import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truck/shop/utlis/platte.dart';

class LiveOrderTraking extends StatefulWidget {
  const LiveOrderTraking({Key key}) : super(key: key);

  @override
  _LiveOrderTrakingState createState() => _LiveOrderTrakingState();
}

class _LiveOrderTrakingState extends State<LiveOrderTraking> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);

  void _onMapCreated(GoogleMapController controller) {
    //_controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red[800]),
        backgroundColor: Colors.white,
        title: Text(
          "Live Track",
          style: kBodyNrmlRedText,
        ),
        elevation: 2,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
