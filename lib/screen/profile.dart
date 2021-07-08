import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/model/user.dart';
import 'package:truck/screen/nav-drawer.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/home.dart';
import 'package:truck/widget/appbar-widget.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final TextEditingController _snnController = new TextEditingController();
  final dateController = new TextEditingController();
  final idController = new TextEditingController();
  final TextEditingController _typeController = new TextEditingController();
  

  var user;
int idVal;
  String firstName;
  String mobile;
  String snn;
  String role;
  
  String dropdownValue="Select Truck";
  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');

//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    //print(user);
    _nameController.text = user['name'];
    _mobileController.text = user['mobile_number'];
    _snnController.text = user['snn'];
    dateController.text = user['dob'];
    idVal = user['id'];
    role=user['role'];
    _typeController.text=user['vehicle_type'];
   // dropdownValue=user['vehicle_type'];
    //print(_dropDownValue);
     setState(() {
    dropdownValue=user['vehicle_type'];
     });
  }

  @override
  void initState() {
    _loadUserData();

    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    //final user = UserPreferences.myUser;
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: buildAppBar(context),
      body: profileView(),
    );
  }

  Widget profileView() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Profiles details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(height: 24, width: 24)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: "name",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    onChanged: (String value) {
                      firstName = value;
                    },
                    validator: (firstNameValue) {
                      if (firstNameValue.isEmpty) {
                        return 'Please enter email';
                      }
                      firstName = firstNameValue;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    controller: _snnController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: "snn",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    onChanged: (String value) {
                      snn = value;
                    },
                    validator: (snnValue) {
                      if (snnValue.isEmpty) {
                        return 'Please enter Snn';
                      }
                      snn = snnValue;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: TextFormField(
                    style: TextStyle(color: Color(0xFF000000)),
                    cursorColor: Color(0xFF9b9b9b),
                    keyboardType: TextInputType.text,
                    controller: _mobileController,
                    decoration: InputDecoration(
                      // prefixIcon: Icon(
                      //   Icons.email,
                      //   color: Colors.grey,
                      // ),
                      hintText: "Mobile",
                      hintStyle: TextStyle(
                          color: Color(0xFF9b9b9b),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    onChanged: (String value) {
                      mobile = value;
                    },
                    validator: (mobileValue) {
                      if (mobileValue.isEmpty) {
                        return 'Please enter mobile';
                      }
                      mobile = mobileValue;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
                    decoration: InputDecoration(hintText: 'Pick your Date'),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  
                  child: DropdownButton<String>(
                    isExpanded: true,
      value: _typeController.text=='' ? dropdownValue : _typeController.text,
      onChanged: (String newValue) {
        //print(newValue);
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Select Truck','Truck', 'Smalltruck']
          .map<DropdownMenuItem<String>>((String value) {
            
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
                ),
        
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      child: Text(
                        _isLoading ? 'Proccessing...' : 'Update',
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
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _update();
                      }
                    },
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget biuldname(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      );
  void _update() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': firstName,
      'dob': dateController.text,
      'snn': snn,
      'id': idVal,
      'mobile_number': mobile,
      'vehicle_type':dropdownValue,
      

    };
    //print(data);
    var res = await Network().authData(data, '/update');
     var body = json.decode(res.body);
     Map<String, dynamic> user = body['userData'];

     //print(body);
  if(res.statusCode == 201){
      print(body['userData']);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.clear();
      localStorage.setString('token', json.encode("fsdsf5344534534"));
      bool result = await localStorage.setString('user', jsonEncode(user));
      //localStorage.setString('user1', json.encode(body['userData']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Home()
          ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
 