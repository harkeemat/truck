import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truck/shop/screens/foodOrder/order_confirm_detail.dart';
import 'package:truck/shop/utlis/platte.dart';

const TWO_PI = 3.14 * 2;

class TrackOrder extends StatefulWidget {
  TrackOrder({Key key}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> with TickerProviderStateMixin {
  final size = 200.0;
  int currentSteps = 0;
  List<Step> steps = [
    Step(
      title: Text(
        'Step 1',
        style: ksmallText,
      ),
      content: Text(
        'Hello!',
        style: ksmallText,
      ),
      isActive: true,
    ),
    Step(
      title: Text(
        'Step 2',
        style: ksmallText,
      ),
      content: Text(
        'World!',
        style: ksmallText,
      ),
      isActive: true,
    ),
    Step(
      title: Text(
        'Step 3',
        style: ksmallText,
      ),
      content: Text(
        'Hello World!',
        style: ksmallText,
      ),
      //state: StepState.complete,
      isActive: true,
    ),
    Step(
      title: Text(
        'Step 4',
        style: ksmallText,
      ),
      content: Text(
        'Hello World!',
        style: ksmallText,
      ),
      state: StepState.complete,
      isActive: true,
    ),
  ];
  AnimationController animationController;

  get emailController => null;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 8800),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red[800],
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Track your oder",
          style: kBodyNrmlRedText,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            iconSize: 18.0,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderConfirm()),
              );
            }),
        elevation: 2,
      ),
      body: ListView(
        primary: false,
        shrinkWrap: true,
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text("Track order", style: kBoldNavigationText),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    child: Text(
                      "Wed, 19 sep",
                      style: ksmallBlackText,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Order ID: MOH123456",
                          style: ksmallBlackText,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Amt: \$80.00",
                          style: ksmallBlackText,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Container(
              child: Text(
                "ETA: 30 Min",
                style: kBoldNavigationText,
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              child: Stepper(
                currentStep: this.currentSteps,
                steps: steps,
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    currentSteps = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (currentSteps < steps.length - 1) {
                      currentSteps = currentSteps + 1;
                    } else {
                      currentSteps = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentSteps > 0) {
                      currentSteps = currentSteps - 1;
                    } else {
                      currentSteps = 0;
                    }
                  });
                },
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.home,
                          color: Colors.black87,
                        ),
                        Column(
                          children: [
                            Text("Delivery Address",
                                style: kNormalBoldBlackText),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                  "Home, Work & Other Address\nHouse No: 1082, 2nd floor sector 59,\nMohali, Punjab, 160059, India",
                                  style: ksmallBlackText,
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.star_fill,
                          color: Colors.black87,
                        ),
                        Column(
                          children: [
                            Text("Don't forget to rate",
                                style: kNormalBoldBlackText),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Good delivery and tasty food",
                                  style: ksmallBlackText,
                                  textAlign: TextAlign.start),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
