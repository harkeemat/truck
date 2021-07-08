import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck/screen/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var name;
  
  var phone;
  var _genderRadioBtnVal;
  var _typeRadioBtnVal;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.teal,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 4.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (emailValue) {
                                  if (emailValue.isEmpty) {
                                    return 'Please enter email';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              // TextFormField(
                              //   style: TextStyle(color: Color(0xFF000000)),
                              //   cursorColor: Color(0xFF9b9b9b),
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //     prefixIcon: Icon(
                              //       Icons.insert_emoticon,
                              //       color: Colors.grey,
                              //     ),
                              //     hintText: "First Name",
                              //     hintStyle: TextStyle(
                              //         color: Color(0xFF9b9b9b),
                              //         fontSize: 15,
                              //         fontWeight: FontWeight.normal),
                              //   ),
                              //   validator: (firstname) {
                              //     if (firstname.isEmpty) {
                              //       return 'Please enter your first name';
                              //     }
                              //     fname = firstname;
                              //     return null;
                              //   },
                              // ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (lastname) {
                                  if (lastname.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  name = lastname;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Phone",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (phonenumber) {
                                  if (phonenumber.isEmpty) {
                                    return 'Please enter phone number';
                                  }
                                  phone = phonenumber;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              Row(
                                children: <Widget>[
                                  _prefixIcon(Icons.person),
                                  Text(
                                    'Gender',
                                    style: TextStyle(color: Color(0xFF000000)),
                                  ),
                                  Radio<String>(
                                    value: "Male",
                                    groupValue: _genderRadioBtnVal,
                                    onChanged: _handleGenderChange,
                                  ),
                                  Text("Male"),
                                  Radio<String>(
                                    value: "Female",
                                    groupValue: _genderRadioBtnVal,
                                    onChanged: _handleGenderChange,
                                  ),
                                  Text("Female"),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  _prefixIcon(Icons.logout),
                                  Text(
                                    'Type',
                                    style: TextStyle(color: Color(0xFF000000)),
                                  ),
                                  Radio<String>(
                                    value: "driver",
                                    groupValue: _typeRadioBtnVal,
                                    onChanged: _handletypeChange,
                                  ),
                                  Text("driver"),
                                  Radio<String>(
                                    value: "client",
                                    groupValue: _typeRadioBtnVal,
                                    onChanged: _handletypeChange,
                                  ),
                                  Text("client"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading
                                          ? 'Proccessing...'
                                          : 'Register',
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
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _register();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Text(
                          'Already Have an Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _prefixIcon(IconData iconData) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
      child: Container(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          margin: const EdgeInsets.only(right: 8.0),
          // decoration: BoxDecoration(
          //     color: Colors.grey.withOpacity(0.2),
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30.0),
          //         bottomLeft: Radius.circular(30.0),
          //         topRight: Radius.circular(30.0),
          //         bottomRight: Radius.circular(10.0))),
          child: Icon(
            iconData,
            size: 20,
            color: Colors.grey,
          )),
    );
  }

  void _handleGenderChange(String value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }
  void _handletypeChange(String value) {
    setState(() {
      _typeRadioBtnVal = value;
    });
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
      'gender': _genderRadioBtnVal,
      'role': _typeRadioBtnVal
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);
     Map<String, dynamic> user = body['userData'];
     
     //print(body);
     //print(user);
    if(res.statusCode == 201){
      //print(body['userData'].id);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
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
