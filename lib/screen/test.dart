import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:truck/model/directions_model.dart';
import 'package:truck/model/directions_repository.dart';
import 'package:truck/screen/feebacksubmit.dart';
import 'package:truck/screen/feedback.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/quick_feedback.dart';

class Test extends StatefulWidget {
  final currentdata;
  const Test({Key key, this.currentdata}) : super(key: key);
  @override
  _MapScreenState createState() =>
      _MapScreenState(currentdata: this.currentdata);
}

class _MapScreenState extends State<Test> {
  final currentdata;
  _MapScreenState({this.currentdata});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(30.733315, 76.779419),
    zoom: 11.5,
  );

  GoogleMapController _googleMapController;
  Marker _origin;
  Marker _car;
  Marker _destination;
  Directions _info;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor pinLocationIcon;
  int driver_id = 21;
  LatLng _currentPosition;
  LatLng _destinationlocations;
  void lcation() async {
    //print(_currentController.text);
    List<Location> Cunrretlocations =
        await locationFromAddress(currentdata.currentLocation);
    List<Location> droplocations =
        await locationFromAddress(currentdata.destinationLocation);
    setState(() {
      _currentPosition = LatLng(
          Cunrretlocations.single.latitude, Cunrretlocations.single.longitude);
      _destinationlocations =
          LatLng(droplocations.single.latitude, droplocations.single.longitude);
    });
  }

  _getCurrentLocation() async {
    //print("dfds");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      if (globalRole == "driver") {
        firestore.collection('users').doc(driver_id.toString()).update({
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
      }

      setState(() {});
    }).catchError((e) {
      print(e);
    });

    var documentSnapshot =
        await firestore.collection('users').doc(driver_id.toString()).get();
    setState(() {
      _currentPosition = LatLng(documentSnapshot.data()["latitude"],
          documentSnapshot.data()["longitude"]);
    });
    //carmark();
    _addMarkerget();
    //print(_currentPosition);
  }

  @override
  void initState() {
    super.initState();

    setSourceAndDestinationIcons();
    //print(pinLocationIcon);
    //_addMarkerget();
    //carmark();
    _getCurrentLocation();
  }

  void setSourceAndDestinationIcons() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving_pin.png');
  }

  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    //print("loaction$userLocation");
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: {
              if (_origin != null) _origin,
              if (_destination != null) _destination,
              if (_car != null) _car
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.green,
                  width: 5,
                  points: _info.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
          ),
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: FlatButton(
                color: globalbutton,
                child: const Text('End ride',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  _showFeedback(context, 21, 27);
                  // Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => FeedbackRate()));
                  //print("gjhghj");
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  void carmark() async {
    //print(_currentPosition);
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving_pin.png');
    setState(() {
      _car = Marker(
        markerId: const MarkerId('car'),
        infoWindow: const InfoWindow(title: 'car'),
        icon: pinLocationIcon,
        position: _currentPosition,
      );
      // Reset destination
    });
  }

  void _addMarkerget() async {
    //print("pose$_currentPosition");

    // Origin is not set OR Origin/Destination are both set
    // Set origin
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: _currentPosition,
      );
      // Reset destination

      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: _destinationlocations,
      );
    });

    //print("_destination${_origin.position}");
    // Origin is already set
    // Set destination

    // Get directions
    final directions = await DirectionsRepository().getDirections(
        origin: _currentPosition, destination: _destinationlocations);
    setState(() => _info = directions);

    //print("info$_info");
  }

  void _addMarker(LatLng pos) async {
    //print("pose$pos");
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(30.735890, 76.811943),
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      //print("_destination${_origin.position}");
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(30.699837, 76.768341),
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
    //print("info$_info");
  }

  void _showFeedback(context, userid, reciverid) {
    print(context);
    showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a feedback', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Share your feedback', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitted: (feedback) {
            //print(feedback['rating']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Feedbacksubmit(feedbackdata: {
                          'booking_number': 3432432,
                          'rating': feedback['rating'],
                          'feedback': feedback['feedback'],
                          'author_id': userid,
                          'author_type': "client",
                          'ratingable_id': reciverid,
                          'ratingable_type': "driver",
                        })));
            //
            //print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
            // Navigator.of(context).pop();
          },
          askLaterText: 'ASK LATER',
          onAskLaterCallback: () {
            print('Do something on ask later click');
          },
        );
      },
    );
  }
}
