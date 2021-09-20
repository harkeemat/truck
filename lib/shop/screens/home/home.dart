import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/screen/product/brand.dart';
import 'package:truck/screen/product/mainPage.dart';
import 'package:truck/screen/product/product.dart';
import 'package:truck/shop/models/foodCategroyModel.dart';
import 'package:truck/shop/models/nearby_restaurant_model.dart';
import 'package:truck/shop/models/top_pick_for_model.dart';
import 'package:truck/shop/screens/home/food_category.dart';
import 'package:truck/shop/screens/home/homeDetail.dart';
import 'package:truck/shop/screens/home/nearby_restaurant.dart';
import 'package:truck/shop/screens/home/top_picks.dart';
import 'package:truck/shop/screens/myAccount/profile.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/bottom_bar.dart';

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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
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
                              globalbranname = newValue;
                              if (newValue == "Brand") {
                                globalisbrand = true;
                                globaliscategory = false;
                                globalisproduct = false;
                              }
                              if (newValue == "Category") {
                                globalisbrand = false;
                                globaliscategory = true;
                                globalisproduct = false;
                              }
                              if (newValue == "Product") {
                                globalisbrand = false;
                                globaliscategory = false;
                                globalisproduct = true;
                              }

                              globalsearchword = "";
                              dropdownvalue = newValue;
                            });
                          },
                          underline: SizedBox(),
                          hint: Text("filter")),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search ',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        ),
                        //onChanged: onItemChanged,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white60, backgroundColor: globalbutton),
                    onPressed: () {
                      print(globaliscategory);
                      print(_textController.text);
                    },
                    child: Text('Search'),
                  )),
                ],
              ),

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
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
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
                                              builder: (context) => Brand()));
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
                            pruductImage(),
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
                              itemBuilder: (BuildContext context, int index) =>
                                  TopPickFood(
                                      item: TopPickForsModel.topPicks[index]))
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
                            itemCount: NearByReasturantModel.reasturants.length,
                            itemBuilder: (BuildContext context, int index) =>
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
              // Container(
              //   child: SizedBox(
              //     width: double.infinity,
              //     height: 100,
              //     child: (FoodCategoryModel.isNotEmpty)
              //         ? ListView.builder(
              //             scrollDirection: Axis.horizontal,
              //             itemCount: FoodCategoryModel.length,
              //             itemBuilder: (BuildContext context, int index) =>
              //                 FoodCategory(
              //                     item: FoodCategoryModel[index]))
              //         : CircularProgressIndicator(),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      //     drawer: Drawer(
      //       child: ListView(
      //         children: [
      //           DrawerHeader(
      //             decoration: BoxDecoration(color: Colors.red[500]),
      //             child: Column(
      //               children: [
      //                 CircleAvatar(
      //                   radius: 50,
      //                   backgroundColor: Colors.black12,
      //                   backgroundImage: AssetImage("assets/images/profile.jpeg"),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(top: 50, left: 50),
      //                     child: SizedBox(
      //                       height: 20,
      //                       width: 20,
      //                       child: Container(
      //                           height: 80,
      //                           child: IconButton(
      //                             icon: Icon(
      //                               CupertinoIcons.camera_circle_fill,
      //                               color: Colors.white,
      //                             ),
      //                             onPressed: () {},
      //                           )),
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   margin: EdgeInsets.only(top: 16),
      //                   child: Text(
      //                     "Gaurav",
      //                     style: ksmallText,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.bag_fill,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Orders",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.suit_heart_fill,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Favorites",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.cart_fill_badge_plus,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Cart",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 Icons.local_offer_rounded,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Discounts",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.bell_fill,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Notifications",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.star_fill,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Rate Us",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //               leading: Icon(
      //                 CupertinoIcons.doc_text_fill,
      //                 color: Colors.black,
      //               ),
      //               title: Text(
      //                 "Ters & Conditions",
      //                 style: kNavigationText,
      //               ),
      //               selected: true,
      //               onTap: () => Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavBar(),
      //                     ),
      //                   )),
      //           ListTile(
      //             leading: Icon(
      //               CupertinoIcons.headphones,
      //               color: Colors.black,
      //             ),
      //             title: Text("Help & Support", style: kNavigationText),
      //             selected: true,
      //             onTap: () => Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => UserProfile(),
      //               ),
      //             ),
      //           ),
      //           ListTile(
      //             leading: Icon(
      //               Icons.settings,
      //               color: Colors.black,
      //             ),
      //             title: Text("Settings", style: kNavigationText),
      //             selected: true,
      //             onTap: () => Navigator.of(context).pop(),
      //           ),
      //           ListTile(
      //             leading: Icon(
      //               CupertinoIcons.lock_fill,
      //               color: Colors.black,
      //             ),
      //             title: Text("Logout", style: kNavigationText),
      //             selected: true,
      //             onTap: () => Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => UserProfile(),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
    );
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
                                  builder: (context) => Product(
                                      brandid: brandmodel[index]['id'])));
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
}
