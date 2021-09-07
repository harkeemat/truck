import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:truck/shop/screens/user/forgotPassword.dart';
import 'package:truck/shop/screens/user/register_page.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/utlis/routes.dart';
import 'package:truck/shop/widgets/background_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool agree = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  validateData() async {
    final isValid = formKey.currentState.validate();

    if (isValid) {
      formKey.currentState?.save();
      print("email  " + emailController.text);
      print("password  " + passwordController.text);

      // final String url = "https://v1.hagglerplanet.com/apis/public/api/login";
      // final response=   await http.post(url, body: {"email": emailController.text, "ln": "en", "password": passwordController.text},
      // headers: {
      //   "device-type" : "A",
      //   "device-id" : "asd",
      //   "Connection" : "Keep-alive",
      //   "api-version" : "v1",
      // });

      setState(() {
        Navigator.pushNamed(context, MyRoutes.bottomBar);
        //  print("user data afer set state" +_userModel.responseData.email);
      });
    } else {
      print("not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 80,
                        child: Center(
                            child: Text(
                          "Food & Package\nDelivery",
                          textAlign: TextAlign.center,
                          style: kHeading,
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    EmailTextInput(
                                      icon: CupertinoIcons.envelope_fill,
                                      hint: "Email",
                                      inputType: TextInputType.emailAddress,
                                      inputAction: TextInputAction.next,
                                      emailController: emailController,
                                    ),
                                    PasswordInput(
                                      icon: CupertinoIcons.lock_fill,
                                      hint: "Password",
                                      inputType: TextInputType.emailAddress,
                                      inputAction: TextInputAction.done,
                                      passwordController: passwordController,
                                    ),
                                    Container(
                                      alignment: FractionalOffset.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Theme(
                                                  data: ThemeData(
                                                      unselectedWidgetColor:
                                                          Colors.white),
                                                  child: Checkbox(
                                                    activeColor:
                                                        Colors.red[500],
                                                    value: agree,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        agree = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text.rich(TextSpan(
                                                    text: 'Remember me ',
                                                    style: ksmallText,
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                          text: "",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "OpenSans",
                                                            color: Colors.red,
                                                          ),
                                                          recognizer:
                                                              new TapGestureRecognizer()
                                                                ..onTap = () {})
                                                    ])),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Text.rich(TextSpan(
                                                text: "",
                                                style: ksmallText,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: "Forgot Password ?",
                                                      style: ksmallText,
                                                      recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ForgotPassword()));
                                                            })
                                                ])),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 5.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            elevation: 8.0,
                                            minimumSize: Size(double.infinity,
                                                40), // double.infinity is the width and 30 is the height
                                          ),
                                          onPressed: () {
                                            validateData();
                                          },
                                          child: Text("Login",
                                              style: kBodyNrmlText),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign in with",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: InkWell(
                                            onTap: () {}, // needed
                                            child: Image.asset(
                                              "assets/images/google_plus.png",
                                              width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            splashColor: Colors.red,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          child: InkWell(
                                            onTap: () {}, // needed
                                            child: Image.asset(
                                              "assets/images/ic_facebook.png",
                                              width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            splashColor: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1))),
                                            child: Text.rich(TextSpan(
                                                text: "Dont have any account ?",
                                                style: ksmallText,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: " Signup",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "OpenSans",
                                                        color: Colors.red,
                                                      ),
                                                      recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Signup()));
                                                            })
                                                ])),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

class EmailTextInput extends StatelessWidget {
  const EmailTextInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.inputType,
      @required this.inputAction,
      @required this.emailController})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          // decoration: BoxDecoration(color: Colors.grey[600]!.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                hintText: hint,
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24, maxHeight: 20),
                prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    )),
                hintStyle: kBodyNrmlText),
            keyboardType: inputType,
            textInputAction: inputAction,
            style: kBodyNrmlText,
            controller: emailController,
            validator: MultiValidator([
              RequiredValidator(errorText: "Required"),
              EmailValidator(errorText: "Enter valid email.")
            ]),
          ),
        ));
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.inputType,
      @required this.inputAction,
      @required this.passwordController})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              hintText: hint,
              prefixIconConstraints:
                  BoxConstraints(minWidth: 24, maxHeight: 20),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              hintStyle: kBodyNrmlText,
            ),
            controller: passwordController,
            keyboardType: inputType,
            textInputAction: inputAction,
            obscureText: true,
            style: kBodyNrmlText,
            validator: MultiValidator([
              RequiredValidator(errorText: "Required"),
              MinLengthValidator(6, errorText: "Atleast 6 char required.")
            ]),
          ),
        ));
  }
}
