// import 'package:flutter/material.dart';
//  class TextWidget extends StatefulWidget {
//    TextWidget({Key  key}) : super(key: key);
 
//    @override
//    _TextWidgetState createState() => _TextWidgetState();
//  }
 
//  class _TextWidgetState extends State<TextWidget> {
//    @override
//    Widget build(BuildContext context) {
     
     
//       return Column(
//    children: <Widget>[
//      SizedBox(
//        height: 20.0,
//      ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: TextField(
//          readOnly: true,
//          controller: dateController,
//        decoration: InputDecoration(hintText: 'Pick Date'),
//          onTap: () async {
//            var date = await showDatePicker(
//                context: context,
//                initialDate: DateTime.now(),
//                firstDate: DateTime(1900),
//                lastDate: DateTime(2100));
//          dateController.text = date.toString().substring(0, 10);
//          },
//        ),
//      ),
//      SizedBox(
//        height: 20.0,
//      ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: TextField(
//          readOnly: true,
//          controller: dropController,
//        decoration: InputDecoration(hintText: 'Drop Date'),
//          onTap: () async {
//            var date = await showDatePicker(
//                context: context,
//                initialDate: DateTime.now(),
//                firstDate: DateTime(1900),
//                lastDate: DateTime(2100));
//          dropController.text = date.toString().substring(0, 10);
//          },
//        ),
//      ),
//      SizedBox(
//        height: 20.0,
//      ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: TextField(
//          controller: _WeightController,
//          decoration: InputDecoration(
//            hintText: 'Weight',
//          ),
//          // onSubmitted: (value) {
//        // },
//        ),
//      ),
//      SizedBox(
//        height: 20.0,
//      ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: TextField(
//          controller: _deminishonsController,
//          decoration: InputDecoration(
//            hintText: 'Deminishons',
//          ),
//          // onSubmitted: (value) {
//        // },
//        ),
//      ),
//      SizedBox(
//        height: 20.0,
//      ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: TextField(
//          controller: _luggageController,
//          decoration: InputDecoration(
//            hintText: 'luggage type',
//          ),
//          // onSubmitted: (value) {
//        // },
//        ),
//      ),
//      SizedBox(
//        height: 20.0,
//      ),
//    SizedBox(
//        height: 100.0,
//        child: ListView.builder(
//          physics: ClampingScrollPhysics(),
//          shrinkWrap: true,
//          scrollDirection: Axis.horizontal,
//          itemCount: 4,
//          itemBuilder: (BuildContext context, int index) => Card(
//            child: InkWell(
//              onTap: () {
//                setState(() {
//                  _dropDownValue.text = "Truck";
//                });
//              },
//              child: CircleAvatar(
//                radius: 70,
//                child: ClipOval(
//                  child: Image.asset(
//                    'assets/images/logo.png',
//                    height: 100,
//                    width: 100,
//                    fit: BoxFit.cover,
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    Padding(
//      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
//        child: TextFormField(
//          style: TextStyle(color: Color(0xFF000000)),
//          cursorColor: Colors.white,
//          readOnly: true,
//          controller: _dropDownValue,
//          decoration: InputDecoration(
//            prefixIcon: Icon(
//              Icons.email,
//              color: Colors.grey,
//            ),
//            hintText: "Vehicle Type",
//            hintStyle: TextStyle(
//                color: Colors.white,
//                fontSize: 15,
//                fontWeight: FontWeight.normal),
//          ),
//        ),
//      ),
//    SizedBox(
//        height: 25.0,
//      ),
//      Padding(
//        padding: const EdgeInsets.all(10.0),
//        child: FlatButton(
//          child: Padding(
//          padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
//            child: Text(
//              'Book Ride Now',
//              textDirection: TextDirection.ltr,
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: 15.0,
//                decoration: TextDecoration.none,
//                fontWeight: FontWeight.normal,
//              ),
//            ),
//          ),
//          color: Colors.teal,
//          disabledColor: Colors.grey,
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(20.0)),
//          onPressed: () async {
//            //order_number = 54353;
//            SharedPreferences localStorage =
//                await SharedPreferences.getInstance();
//            final user = jsonDecode(localStorage.getString('user'));
//            final sendValue = {
//              "sender_id": user['id'],
//              "sender_name": user['name'],
//              "luggage": _luggageController.text,
//              "deminishons": _deminishonsController.text,
//              "Weight": _WeightController.text,
//              "dropdate": dropController.text,
//              "Distance": _placeDistance,
//              "date": dateController.text,
//              "current": _startAddress,
//              "drop": _destinationAddress,
//              "title": "Click to Ride Book",
//              "body": "Accept the booking"
//            };
//            order_number = sumitorder(sendValue);
//            data.clear();
//            getData();
//          },
//        ),
//    ),
//      Padding(
//        padding: EdgeInsets.all(2),
//        child: Column(
//          children: [
//          isOn == true
//                ? Card(
//                    color: Colors.grey[800],
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: new Wrap(
//                        spacing: 8.0, // gap between adjacent chips
//                        runSpacing: 4.0, // gap between lines
//                        direction: Axis.horizontal,
//                        children: <Widget>[
//                          Text(
//                            "Click to send all driver notification",
//                            style:
//                                TextStyle(color: Colors.white, fontSize: 15),
//                          ),
//                          Spacer(),
//                          ElevatedButton(
//                            onPressed: () {
//                              allsend();
//                              timer = Timer.periodic(Duration(seconds: 45),
//                                  (Timer t) => get_approve());
//                            },
//                            child: Text('Send',
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 13)),
//                            style: ElevatedButton.styleFrom(
//                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(10))),
//                          )
//                        ],
//                      ),
//                    ),
//                  )
//                : Center(),
//            data != null
//                ? new ListView.builder(
//                    scrollDirection: Axis.vertical,
//                    shrinkWrap: true,
//                    itemCount: data == null ? 0 : data.length,
//                    itemBuilder: (BuildContext context, int index) {
//                    //print(data[index]);
//                      return _dropDownValue.text ==
//                              data[index]['vehicle_type']
//                          ? personDetailCard(data[index])
//                          : Center();
//                    },
//                  )
//                : Center(),
//          ],
//        ),
//      ),
//    ],
//  );
//    }
//  }