import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

import 'package:truck/shop/screens/user/reset_password.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/background_image.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key key}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification>
    with SingleTickerProviderStateMixin {
  final int time = 30;
  //AnimationController _controller;

  var formKey = GlobalKey<FormState>();
  void validatData() {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState?.save();
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
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.black.withOpacity(0.0),
              elevation: 0.0,
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              child: Center(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(
                              child: Image(
                                image:
                                    AssetImage("assets/images/lock_icon.png"),
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //margin: const EdgeInsets.only(top: 20),
                          height: 100,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 50,
                                // ),
                                Text(
                                  " OTP Verification ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    "Please enter your OTP code send to your mobile number. ",
                                    textAlign: TextAlign.center,
                                    style: ksmallText,
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: 64.0,
                                            width: 56.0,
                                            child: Card(
                                                color: Color.fromRGBO(
                                                    173, 179, 191, 0.7),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),

                                                  //child: TextEditorForPhoneVerify(this.codeOne)
                                                ))),
                                        Container(
                                            height: 64.0,
                                            width: 56.0,
                                            child: Card(
                                                color: Color.fromRGBO(
                                                    173, 179, 191, 0.7),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  //child: TextEditorForPhoneVerify(this.codeOne)
                                                ))),
                                        Container(
                                            height: 64.0,
                                            width: 56.0,
                                            child: Card(
                                                color: Color.fromRGBO(
                                                    173, 179, 191, 0.7),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  //child: TextEditorForPhoneVerify(this.codeOne)
                                                ))),
                                        Container(
                                            height: 64.0,
                                            width: 56.0,
                                            child: Card(
                                                color: Color.fromRGBO(
                                                    173, 179, 191, 0.7),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  //child: TextEditorForPhoneVerify(code),
                                                ))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 20),
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
                                            // validatData();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ResetPassword()));
                                          },
                                          child: Text("Verify",
                                              style: kBodyNrmlText),
                                        )),
                                    Container(
                                      child: Row(
                                        //crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Colors.white,
                                                        width: 1))),
                                            child: Text.rich(TextSpan(
                                                text: "Dont recieve the OTP ?",
                                                style: ksmallText,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                      text: " Resend OTP",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "OpenSans",
                                                        color: Colors.red,
                                                      ),
                                                      recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () {
                                                              // Navigator.push(
                                                              //     context,
                                                              //     MaterialPageRoute(
                                                              //         builder:
                                                              //             (context) =>
                                                              //                 Signup()
                                                              //                 )
                                                              //                 );
                                                            })
                                                ])),
                                          ),
                                        ],
                                      ),
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
            )),
      ],
    );
  }
}

class TextEditorForPhoneVerify extends StatelessWidget {
  final TextEditingController code;

  TextEditorForPhoneVerify(this.code);

  @override
  Widget build(BuildContext context) {
    return TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: this.code,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            hintText: "*",
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)));
  }
}
// class MobileInput extends StatelessWidget {
//   const MobileInput(
//       {Key? key,
//         required this.icon,
//         required this.hint,
//         required this.inputType,
//         required this.inputAction,
//         required this.mobileController})
//       : super(key: key);

//   final IconData icon;
//   final String hint;
//   final TextInputType inputType;
//   final TextInputAction inputAction;
//   final TextEditingController mobileController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 30.0),
//         child: Container(
//           // decoration: BoxDecoration(
//           //     color: Colors.grey[600]!.withOpacity(0.5),
//           //     borderRadius: BorderRadius.circular(10)),
//           child: TextFormField(
//             decoration: InputDecoration(
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10),
//                 prefixIconConstraints:
//                 BoxConstraints(minWidth: 24, maxHeight: 20),
//                 hintText: hint,
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Icon(
//                     icon,
//                     color: Colors.white,
//                   ),
//                 ),
//                 hintStyle: kBodyNrmlText),
//             keyboardType: TextInputType.number,
//             textInputAction: inputAction,
//             style: kBodyNrmlText,
//             controller: mobileController,
//             validator: RequiredValidator(errorText: "Required"),
//           ),
//         ));
//   }
// }
