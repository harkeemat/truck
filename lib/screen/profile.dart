import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/nav-drawer.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/home.dart';
import 'package:truck/widget/appbar-widget.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController _merchantController = new TextEditingController();
  final TextEditingController _privateKeyController =
      new TextEditingController();
  final TextEditingController _publicKeyController =
      new TextEditingController();
  final TextEditingController _licenceController = new TextEditingController();

  int defaultChoiceIndex;
  List<String> _choicesList = ['All', 'Pending', 'Accepted'];
  var user;
  int idVal;
  String firstName;
  String mobile;
  String snn;
  String role;
  String licence;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  String dropdownValue = "Select Truck";
  //image
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker(); //variable for choosed file
  String image;
  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user'));
    //String userPref = localStorage.getString('user');

//Map<String,dynamic> userMap = jsonDecode(userPref) as Map<String, dynamic>;
    //print(user);

    // dropdownValue=user['vehicle_type'];
    //print(_dropDownValue);
    setState(() {
      _nameController.text = user['name'];
      _mobileController.text = user['mobile_number'];
      _snnController.text = user['snn'];
      dateController.text = user['dob'];
      idVal = user['id'];
      role = user['role'];
      _typeController.text = user['vehicle_type'];
      _licenceController.text = user['licence'];
      if (user['image'] != null) {
        image = Network().imageget + "/" + user['image'];
      }
    });
  }

  List alertdata;
  getvehicle() async {
    var res = await Network().getData('/getvehicle');
    final jsonresponse = json.decode(res.body);

    //print(jsonresponse['vehicle']);
    this.setState(() {
      alertdata = jsonresponse['vehicle'];
    });
    //print(alertdata);
  }

  @override
  void initState() {
    _loadUserData();
    getvehicle();
    super.initState();
    defaultChoiceIndex = 0;
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
        body: SingleChildScrollView(child: profileView()));
  }

  Widget profileView() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _nameController.text,
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
                imageProfile(),
              ],
            ),
          ),
          Center(
            child: Expanded(
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
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        hintText: "name",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      onChanged: (String value) {
                        firstName = value;
                      },
                      validator: (firstNameValue) {
                        if (firstNameValue.isEmpty) {
                          return 'Please enter name';
                        }
                        firstName = firstNameValue;
                        return null;
                      },
                    ),
                  ),
                  if (globalRole == "driver")
                    SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: alertdata == null ? 0 : alertdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    dropdownValue = alertdata[index]['name'];
                                    _typeController.text =
                                        alertdata[index]['name'];
                                  });
                                },
                                child: Image(
                                  image: NetworkImage(Network().imageget +
                                      "/" +
                                      alertdata[index]['image']),
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
                  if (globalRole == "driver")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Colors.white,
                        readOnly: true,
                        controller: _merchantController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: "merchantId",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  if (globalRole == "driver")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Colors.white,
                        readOnly: true,
                        controller: _publicKeyController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: "publicKey",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  if (globalRole == "driver")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Colors.white,
                        readOnly: true,
                        controller: _typeController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: "privateKey",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  if (globalRole == "driver")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Colors.white,
                        readOnly: true,
                        controller: _typeController,
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
                  if (globalRole == "driver")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                      child: TextFormField(
                        style: TextStyle(color: Color(0xFF000000)),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: _licenceController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          hintText: "licence number",
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                        onChanged: (String value) {
                          licence = value;
                        },
                        validator: (licenceValue) {
                          if (licenceValue.isEmpty) {
                            return 'Please enter licence number';
                          }
                          licence = licenceValue;
                          return null;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                    child: TextFormField(
                      style: TextStyle(color: Color(0xFF000000)),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: _snnController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        hintText: "snn",
                        hintStyle: TextStyle(
                            color: Colors.white,
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
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: _mobileController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        hintText: "Mobile",
                        hintStyle: TextStyle(
                            color: Colors.white,
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        ),
                        hintText: "DOB",
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
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
                  // Padding(
                  // padding: const EdgeInsets.all(10.0),
                  // child: Row(
                  // children: [
                  // Chip(
                  // avatar: CircleAvatar(
                  // backgroundColor: Colors.grey.shade800,
                  // child: Image(
                  // image: AssetImage('assets/images/logo2.jpg'),
                  // height: 150,
                  // width: 150,
                  // ),
                  // ),
                  // label: Text(''),
                  // ),
                  // Chip(
                  // avatar: CircleAvatar(
                  // backgroundColor: Colors.grey.shade800,
                  // child: Image(
                  // image: AssetImage('assets/images/logo2.jpg'),
                  // height: 150,
                  // width: 150,
                  // ),
                  // ),
                  // label: Text(''),
                  // ),
                  // Chip(
                  // avatar: CircleAvatar(
                  // backgroundColor: Colors.grey.shade800,
                  // child: Image(
                  // image: AssetImage('assets/images/logo2.jpg'),
                  // height: 150,
                  // width: 150,
                  // ),
                  // ),
                  // label: Text(''),
                  // ),
                  // Chip(
                  // avatar: CircleAvatar(
                  // backgroundColor: Colors.grey.shade800,
                  // child: Image(
                  // image: AssetImage('assets/images/logo2.jpg'),
                  // height: 150,
                  // width: 150,
                  // ),
                  // ),
                  // label: Text(''),
                  // ),
                  // ],
                  // ),
                  // ),
                  // Padding(
                  // padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                  // child: DropdownButton<String>(
                  // isExpanded: true,
                  // value: _typeController.text == ''
                  // ? dropdownValue
                  // : _typeController.text,
                  // onChanged: (String newValue) {
                  //print(newValue);
                  // setState(() {
                  // dropdownValue = newValue;
                  // });
                  // },
                  // items: <String>['Select Truck', 'Truck', 'Smalltruck']
                  // .map<DropdownMenuItem<String>>((String value) {
                  // return DropdownMenuItem<String>(
                  // value: value,
                  // child: Text(value),
                  // );
                  // }).toList(),
                  // ),
                  // ),
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
                      color: globalbutton,
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
            )),
          )
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? NetworkImage(image)
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
  // Widget biuldname(User user) => Column(
  // children: [
  // Text(
  // user.name,
  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  // ),
  // const SizedBox(height: 4),
  // Text(
  // user.email,
  // style: TextStyle(
  // color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),
  // ),
  // ],
  // );

  void _update() async {
    // print(_imageFile.path);
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': firstName,
      'dob': dateController.text,
      'snn': snn,
      'id': idVal,
      'mobile_number': mobile,
      'merchantId': _merchantController.text,
      'publicKey': _publicKeyController.text,
      'privateKey': _privateKeyController.text,
      'vehicle_type':
          _typeController.text != null ? _typeController.text : null,
      'licence':
          _licenceController.text != null ? _licenceController.text : null,
    };
//print(data);
    if (_imageFile != null) {
      var imageResponse =
          await Network().patchImage("/get_name", _imageFile.path, idVal);
    }
    
    

    var res = await Network().authData(data, '/update');
    var body = json.decode(res.body);
    Map<String, dynamic> user = body['userData'];

    //print("cod $imageResponse");
    if (res.statusCode == 201) {
      //print(body['userData']);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.clear();
      localStorage.setString('token', json.encode("fsdsf5344534534"));
      bool result = await localStorage.setString('user', jsonEncode(user));
      print(result);
      _showMsg("Update profile data");
      //localStorage.setString('user1', json.encode(body['userData']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Home()),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
