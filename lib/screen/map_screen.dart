  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:geocoding/geocoding.dart';
  import 'package:geolocator/geolocator.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';

  import 'package:truck/model/directions_model.dart';
  import 'package:truck/model/directions_repository.dart';
  import 'package:truck/screen/feebacksubmit.dart';

  import 'package:truck/screen/my-globals.dart';
  import 'package:truck/screen/quick_feedback.dart';

  class MapScreen extends StatefulWidget {
    MapScreen({Key key, this.userdata}) : super(key: key);
    final userdata;
    @override
    _MapScreenState createState() => _MapScreenState(userdata: this.userdata);
  }

  class _MapScreenState extends State<MapScreen> {
    final userdata;
    _MapScreenState({this.userdata});
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(37.4219983, -122.084),
      zoom: 11.5,
    );

    double destinationLatitude;
    double destinationLongitude;
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
    GoogleMapController mapController;
    _getCurrentLocation() async {
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        setState(() {
          //print('CURRENT POS: $position');
          // mapController.animateCamera(
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18.0,
              ),
            ),
          );
        });

        if (globalRole == "driver") {
          firestore.collection('users').doc(driver_id.toString()).update({
            'latitude': position.latitude,
            'longitude': position.longitude,
          });
        }
      }).catchError((e) {
        print(e);
      });
      var documentSnapshot =
          await firestore.collection('users').doc(driver_id.toString()).get();
      setState(() {
        //_currentPosition = LatLng(37.44344583192005, -122.1189621090889);
        _currentPosition = LatLng(documentSnapshot.data()["latitude"],
            documentSnapshot.data()["longitude"]);
      });
      try {
        List<Location> destinationPlacemark =
            await locationFromAddress(userdata['drop_location']);
        setState(() {
          //print("ghh${destinationPlacemark[0]}");

          //_destinationlocations = LatLng(30.7333139, 77.1543729);
          //lat: 30.7333139, lng: 77.1543729
          _destinationlocations = LatLng(destinationPlacemark[0].latitude,
              destinationPlacemark[0].longitude);
          // destinationLatitude = destinationPlacemark[0].latitude;
          // destinationLongitude = destinationPlacemark[0].longitude;
        });
      } catch (e) {
        print(e);
      }
      carmark();
      _addMarkerget();

  // Retrieving placemarks from addresses
    }

    @override
    void initState() {
      super.initState();
      //print(userdata['drop_location']);
      _calculateDistance();
      setSourceAndDestinationIcons();
      _getCurrentLocation();
      //print(pinLocationIcon);
      //_addMarkerget();
      //carmark();
    }

    Future<bool> _calculateDistance() async {
      return false;
    }

    void setSourceAndDestinationIcons() async {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5),
          'assets/images/driving_pin.png');

      // List<Location> destinationPlacemark =
      // await locationFromAddress(userdata['drop_location']);
      // setState(() {
      // destinationLatitude = destinationPlacemark[0].latitude;
      // destinationLongitude = destinationPlacemark[0].longitude;
      // });
    }

    void dispose() {
      _googleMapController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      //_getCurrentLocation();
      //print("loaction$userLocation");
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Google Maps'),
          actions: [
            if (_origin != null)
              TextButton(
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _origin.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('ORIGIN'),
              ),
            if (_destination != null)
              TextButton(
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _destination.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('DEST'),
              )
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              tiltGesturesEnabled: false,

              initialCameraPosition: _initialCameraPosition,
              //onMapCreated: (controller) => _googleMapController = controller,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },

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
              onLongPress: _addMarker,
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
                    _showFeedback(context);
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
      print(_currentPosition);
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

      //print("_destination$destinationLatitude");
      // Origin is already set
      // Set destination

      // Get directions
      final directions = await DirectionsRepository().getDirections(
          origin: _currentPosition, destination: _destinationlocations);
      setState(() => _info = directions);

      print("info$_info");
    }

    void _addMarker(LatLng pos) async {
      if (_origin == null || (_origin != null && _destination != null)) {
        // Origin is not set OR Origin/Destination are both set
        // Set origin
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('origin'),
            infoWindow: const InfoWindow(title: 'Origin'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            position: pos,
          );
          // Reset destination
          _destination = null;

          // Reset info
          _info = null;
        });
      } else {
        // Origin is already set
        // Set destination
        setState(() {
          _destination = Marker(
            markerId: const MarkerId('destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            position: pos,
          );
        });

        // Get directions
        final directions = await DirectionsRepository()
            .getDirections(origin: _origin.position, destination: pos);
        setState(() => _info = directions);
      }
    }

    void _showFeedback(context) {
      //print(context);
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
                            'booking_number': userdata['order_number'],
                            'rating': feedback['rating'],
                            'feedback': feedback['feedback'],
                            'author_id': globalInt,
                            'author_type': globalRole,
                            'ratingable_id': globalRole == "driver"
                                ? userdata['user_id']
                                : userdata['driver_id'],
                            'ratingable_type':
                                globalRole == "driver" ? "client" : "driver",
                          })));
              //
              //print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
              // Navigator.of(context).pop();
            },
            askLaterText: 'ASK LATER',
            onAskLaterCallback: () {
              /// print('Do something on ask later click');
            },
          );
        },
      );
    }
  }
