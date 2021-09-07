import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/utlis/routes.dart';
import 'package:truck/shop/widgets/background_image.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController mobileController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  void validatData() {
    final isValid = formKey.currentState.validate();
    if (isValid) {
      formKey.currentState?.save();
    setState(() {
        Navigator.pushNamed(context, MyRoutes.bottomBar);
     //  print("user data afer set state" +_userModel.responseData.email);
    });
      print("mobile  " + mobileController.text);

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
            leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop(),),
            backgroundColor: Colors.black.withOpacity(0.0),
            elevation: 0.0,
          ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                          height: 100,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: InkWell(child: Image(image: AssetImage("assets/images/lock_icon.png"), 
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
                                " Reset your password ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24 ,fontFamily : "OpenSans",fontWeight: FontWeight.w700 ,color: Colors.red,),
                              ),
                            Container(
                            padding: const EdgeInsets.only(top:20.0),
                            child:   Text(
                                "We have sent a four digit code on your phone",
                                textAlign: TextAlign.center,
                                style: ksmallText,
                              ),
                            )
                            ]
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(  horizontal: 40, vertical: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                          children: [
                              Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MobileInput(
                                icon: CupertinoIcons.bandage_fill,
                                hint: "New password",
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                mobileController: mobileController,),
                            ],
                          ),
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MobileInput(
                                icon: CupertinoIcons.bandage_fill,
                                hint: "Confirm new password",
                                inputType: TextInputType.number,
                                inputAction: TextInputAction.next,
                                mobileController: mobileController,),
                            ],
                          ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                    elevation: 8.0,
                                    minimumSize: Size(double.infinity,
                                        40), // double.infinity is the width and 30 is the height
                                  ),
                                  onPressed: () {
                                    validatData();
                                    
                                  },
                                  child: Text("Update Password", style: kBodyNrmlText),
                                )),
                          ],
                        )
                        ],
                      ),
                          ),),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
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
        padding: const EdgeInsets.symmetric(vertical: 30.0),
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
