import 'dart:convert';
import 'dart:ui';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck/model/nearby_restaurant_model.dart';
import 'package:truck/model/top_pick_for_model.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/product/brand.dart';
import 'package:truck/screen/product/home/nearby_restaurant.dart';
import 'package:truck/screen/product/home/top_picks.dart';
import 'package:truck/screen/product/product.dart';
import 'package:truck/utlis/platte.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textController = TextEditingController();
  final picker = ImagePicker();
  List brandmodel;
  List categorymodel;
  foodCategory() async {
    var res = await Network().getData('/getbrand/');
    var catres = await Network().getData('/getcategory/');
    final catejsonresponse = json.decode(catres.body);
    final jsonresponse = json.decode(res.body);
    //print(catejsonresponse['data']);
    this.setState(() {
      brandmodel = jsonresponse['data'];
      categorymodel = catejsonresponse['data'];
    });
    //final List<Item> foodCategoryList = jsonresponse['data'];
  }
  //final List<Item> foodCategoryList = FoodCategoryModel.FoodCategory;

  //var myFile = File("image");
  var pickedFile;
  onItemChanged(String value) {
    print(value);
  }

  bool isliked = false;
  String dropdownvalue = 'Brand';
  var items = [
    'Brand',
    'Category',
    'Product',
  ];
  @override
  void initState() {
    //print(FoodCategoryModel.FoodCategory);
    super.initState();
    foodCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Carousel(
                      dotSize: 4.0,
                      dotSpacing: 10,
                      indicatorBgPadding: 5.0,
                      dotColor: Colors.red,
                      dotBgColor: Colors.transparent,
                      dotVerticalPadding: 5.0,
                      dotPosition: DotPosition.bottomCenter,
                      images: [
                        Card(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/pic1.jpg",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.centerLeft,
                                        colors: [
                                          Colors.black45.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          2.0
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Get upto \n 50% off",
                                    style: kBodyNrmlRedText),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/pic3.jpg",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.centerLeft,
                                        colors: [
                                          Colors.black45.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          2.0
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Get upto \n 50% off",
                                    style: kBodyNrmlRedText),
                              )
                            ],
                          ),
                        ),
                        Card(
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/images/pic2.jpg",
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.centerLeft,
                                        colors: [
                                          Colors.black45.withOpacity(0.0),
                                          Colors.black87,
                                        ],
                                        stops: [
                                          0.0,
                                          2.0
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Get upto \n 50% off",
                                    style: kBodyNrmlRedText),
                              )
                            ],
                          ),
                        ),

                        // InkWell(
                        //     onTap: () {
                        //       setState() {}
                        //     },
                        //     child: Image.asset(
                        //       "assets/images/pic1.jpg",
                        //       fit: BoxFit.cover,
                        //     )),
                        //
                      ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 99,
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: DropdownButton(
                            value: dropdownvalue,
                            elevation: 16,
                            icon: Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownvalue = newValue;
                              });
                            },
                            underline: SizedBox(),
                            hint: Text("filter")),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        // border: InputBorder.,

                        hintText: 'Search ',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      ),
                      //onChanged: onItemChanged,
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: globalbutton,
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Product(brandname: {
                                      "brandname": dropdownvalue,
                                      "searchby": _textController.text,
                                      "id": null
                                    })));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Spacer(),
                  ]),
              // isliked == true
              //     ? Allproduct(brandname: {
              //         "brandname": dropdownvalue,
              //         "searchby": _textController.text,
              //         "id": null
              //       })
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              categorymodel == null ? 0 : categorymodel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          categorymodel[index]['name'],
                                          style: ksmallBoldBlackText,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Brand()));
                                          // setState() {

                                          // }
                                        },
                                        child: Text(
                                          "See all",
                                          style: ksmallBoldBlackText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 150,
                                    child: (brandmodel.isNotEmpty)
                                        ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: brandmodel.length,
                                            itemBuilder: (BuildContext context,
                                                    int index) =>
                                                //print(brandmodel[index]);
                                                brands(brandmodel[index]))
                                        : CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            );
                          })
                      //: Center(child: CircularProgressIndicator()),

                      ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text("Top Picks For You",
                                  style: ksmallBoldBlackText),
                            ),
                            Container(
                              child: Text(
                                "See all",
                                style: ksmallBoldBlackText,
                                textScaleFactor: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: (TopPickForsModel.topPicks.isNotEmpty)
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: TopPickForsModel.topPicks.length,
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      TopPickFood(
                                          item:
                                              TopPickForsModel.topPicks[index]))
                              : CircularProgressIndicator(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text("Near By Restaurant",
                                    style: ksmallBoldBlackText)),
                            Container(
                              child: Text(
                                "See all",
                                style: ksmallBoldBlackText,
                                textScaleFactor: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          child: SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: (NearByReasturantModel.reasturants.isNotEmpty)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    NearByReasturantModel.reasturants.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        NearByReataurant(
                                            item: NearByReasturantModel
                                                .reasturants[index]))
                            : CircularProgressIndicator(),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Meal Deals",
                            style: ksmallBoldBlackText,
                            textScaleFactor: 1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "See all",
                            style: ksmallBoldBlackText,
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget brands(item) {
    print("dfdf${item['logo']}");
    return SizedBox(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Product(brandname: {
                            "brandname": null,
                            "searchby": null,
                            "id": item['id']
                          })));
            },
            child: Card(
              elevation: 2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 80,
                      width: 120,
                      margin: EdgeInsets.all(6.0),
                      child: Image.network(
                          Network().imageget + "/" + item['logo'],
                          fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "${item['name']}",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${item['slug']}",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${item['address']}",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget pruductImage() {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: brandmodel != null
            ? ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brandmodel == null ? 0 : brandmodel.length,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                      child: InkWell(
                        onTap: () {
                          globalbrandid = brandmodel[index]['id'];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Product(brandname: {
                                        "brandname": null,
                                        "searchby": null,
                                        "id": brandmodel[index]['id']
                                      })));
                        },
                        child: Card(
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                                Network().imageget +
                                    "/" +
                                    brandmodel[index]['logo'],
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                    ))
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget nearby(BuildContext context) => SizedBox(
          child: Card(
        elevation: 2,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.all(6.0),
                child: Image.network("fdd", fit: BoxFit.fill)),
            Container(
              child: Text(
                "sdfds",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ));
}
