import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:truck/shop/screens/user/login_page.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/background_image.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool agree = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  void validateSignUpData() {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState?.save();
      print("email  " + emailController.text);
      print("password  " + passwordController.text);
      print("mobile  " + mobileController.text);
      print("username  " + usernameController.text);
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
                      // margin: const EdgeInsets.only(top: 20),
                      height: 100,
                      child: Center(
                          child: Text(
                        "Food & Package\nDelivery",
                        textAlign: TextAlign.center,
                        style: kHeading,
                      )),
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
                                UsernameInput(
                                  icon: CupertinoIcons.profile_circled,
                                  hint: "Username",
                                  inputType: TextInputType.name,
                                  inputAction: TextInputAction.next,
                                  userNameController: usernameController,
                                ),
                                MobileInput(
                                  icon: CupertinoIcons.phone,
                                  hint: "Mobile",
                                  inputType: TextInputType.number,
                                  inputAction: TextInputAction.next,
                                  mobileController: mobileController,
                                ),
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
                                //_MyHomePage(),
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: Colors.white),
                                      child: Checkbox(
                                        activeColor: Colors.red[500],
                                        value: agree,
                                        onChanged: (value) {
                                          setState(() {
                                            agree = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'I agree to the',
                                        style: ksmallText,
                                        children: <InlineSpan>[
                                          TextSpan(
                                              text: " Terms and Conditions",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: "OpenSans",
                                                color: Colors.red,
                                              ),
                                              recognizer:
                                                  new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             LoginScreen()));
                                                    })
                                        ]))
                                  ],
                                ),
                                //ElevatedButton(onPressed: agree ? _doSomething : null, child: Text('Read Term & Conditions')),
                                SizedBox(
                                  height: 20,
                                ),

                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 5.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        elevation: 8.0,
                                        minimumSize: Size(double.infinity,
                                            40), // double.infinity is the width and 30 is the height
                                      ),
                                      onPressed: () {
                                        validateSignUpData();
                                      },
                                      child: Text("Create Account",
                                          style: kBodyNrmlText),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 1))),
                                  child: Text.rich(TextSpan(
                                      text: "If you are an existing user ?",
                                      style: ksmallText,
                                      children: <InlineSpan>[
                                        TextSpan(
                                            text: " Login",
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
                                                            builder: (context) =>
                                                                LoginScreen()));
                                                  })
                                      ])),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class UsernameInput extends StatelessWidget {
  const UsernameInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.inputType,
      @required this.inputAction,
      @required this.userNameController})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          // decoration: BoxDecoration(
          //     color: Colors.grey[600]!.withOpacity(0.5),
          //     borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24, maxHeight: 20),
                hintText: hint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                hintStyle: kBodyNrmlText),
            keyboardType: inputType,
            textInputAction: inputAction,
            style: kBodyNrmlText,
            controller: userNameController,
            validator: RequiredValidator(errorText: "Required"),
          ),
        ));
  }
}

class MobileInput extends StatelessWidget {
  const MobileInput(
      {Key key,
      @required this.icon,
      @required this.hint,
      @required this.inputType,
      @required this.inputAction,
      @required this.mobileController})
      : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController mobileController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          // decoration: BoxDecoration(
          //     color: Colors.grey[600]!.withOpacity(0.5),
          //     borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 24, maxHeight: 20),
                hintText: hint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                hintStyle: kBodyNrmlText),
            keyboardType: TextInputType.number,
            textInputAction: inputAction,
            style: kBodyNrmlText,
            controller: mobileController,
            validator: RequiredValidator(errorText: "Required"),
          ),
        ));
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
