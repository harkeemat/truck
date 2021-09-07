import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truck/screen/product/mainPage.dart';
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
  final picker = ImagePicker();
  final List<Item> foodCategoryList = FoodCategoryModel.FoodCategory;

  //var myFile = File("image");
  var pickedFile;

  @override
  void initState() {
    super.initState();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Choose Food",
                        style: ksmallBoldBlackText,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
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
                  height: 100,
                  child: (FoodCategoryModel.FoodCategory.isNotEmpty)
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: FoodCategoryModel.FoodCategory.length,
                          itemBuilder: (BuildContext context, int index) =>
                              FoodCategory(
                                  item: FoodCategoryModel.FoodCategory[index]))
                      : CircularProgressIndicator(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child:
                          Text("Top Picks For You", style: ksmallBoldBlackText),
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
                                item: NearByReasturantModel.reasturants[index]))
                    : CircularProgressIndicator(),
              )),
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
              Container(
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: (FoodCategoryModel.FoodCategory.isNotEmpty)
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: FoodCategoryModel.FoodCategory.length,
                          itemBuilder: (BuildContext context, int index) =>
                              FoodCategory(
                                  item: FoodCategoryModel.FoodCategory[index]))
                      : CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red[500]),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black12,
                    backgroundImage: AssetImage("assets/images/profile.jpeg"),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 50),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Container(
                            height: 80,
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.camera_circle_fill,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      "Gaurav",
                      style: ksmallText,
                    ),
                  )
                ],
              ),
            ),
            ListTile(
                leading: Icon(
                  CupertinoIcons.bag_fill,
                  color: Colors.black,
                ),
                title: Text(
                  "Orders",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  CupertinoIcons.suit_heart_fill,
                  color: Colors.black,
                ),
                title: Text(
                  "Favorites",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  color: Colors.black,
                ),
                title: Text(
                  "Cart",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  Icons.local_offer_rounded,
                  color: Colors.black,
                ),
                title: Text(
                  "Discounts",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  CupertinoIcons.bell_fill,
                  color: Colors.black,
                ),
                title: Text(
                  "Notifications",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.black,
                ),
                title: Text(
                  "Rate Us",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
                leading: Icon(
                  CupertinoIcons.doc_text_fill,
                  color: Colors.black,
                ),
                title: Text(
                  "Ters & Conditions",
                  style: kNavigationText,
                ),
                selected: true,
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavBar(),
                      ),
                    )),
            ListTile(
              leading: Icon(
                CupertinoIcons.headphones,
                color: Colors.black,
              ),
              title: Text("Help & Support", style: kNavigationText),
              selected: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text("Settings", style: kNavigationText),
              selected: true,
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.lock_fill,
                color: Colors.black,
              ),
              title: Text("Logout", style: kNavigationText),
              selected: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
