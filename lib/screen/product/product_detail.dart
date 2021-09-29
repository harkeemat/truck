import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:truck/model/cartmodel.dart';
import 'package:truck/network_utils/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:truck/screen/cart/cart_page.dart';

import 'package:scoped_model/scoped_model.dart';


class ItemDetailPage extends StatefulWidget {
  final int itemId;

  ItemDetailPage({@required this.itemId});

  @override
  _ItemDetailPageState createState() =>
      _ItemDetailPageState(itemId: this.itemId);
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  PageController pageController;
  final int itemId;
  _ItemDetailPageState({this.itemId});

  int active = 0;

  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc_R7jxbs8Mk2wjW9bG6H9JDbyEU_hRHmjhr3EYn-DYA99YU6zIw";
  List _products;
  //List test;
  fetchData() async {
    //print(_products2);

    var res = await Network().getData('/product_detail/$itemId');

    final jsonResponse = json.decode(res.body);
    // List rawFavouriteList = jsonResponse['data'];
    // List _faouriteList =
    //     rawFavouriteList.map((item) => Product.fromJson(item)).toList();

    // return _faouriteList;
    setState(() {
      _products = jsonResponse['data'].map((data) {
        //print("data4 $data");

        return Product(
            id: data['id'],
            name: data['name'],
            price: data['price'],
            image: data['image'],
            brandid: data['brand_id'],
            categoryid: data['category_id'],
            sku: data['sku'],
            slug: data['slug'],
            description: data['description'],
            qty: data['quantity'],
            weight: data['image'],
            rating: data['rating'],
            saleprice: data['sale_price']);
      }).toList();
    });

    //print(_products[0]);
    // //   _products = jsonResponse['data']
    //       .map((data) => new Product.fromJson(data))
    //       .toList();
    //

    //_products = jsonresponse['data'];

    //return jsonresponse['data'];
  }

  bool isClicked = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    //print(object)
    return Scaffold(
      bottomNavigationBar: _products != null
          ? Container(
              color: Theme.of(context).backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 11,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          child: Divider(
                            color: Colors.black26,
                            height: 4,
                          ),
                          height: 24,
                        ),
                        Text(
                          "\$ ${_products[0].saleprice}",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "\$ ${_products[0].price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
//            new Container(
//              color: Colors.transparent,
//              child: new Container(
//                  width: 48,
//                  height: 48,
//                  decoration: new BoxDecoration(
//                    border: Border.all(width: 1.0, color: Colors.black26),
//                    borderRadius: new BorderRadius.all(
//                      Radius.circular(8.0),
//                    ),
//                  ),
//                  child: new Center(
//                    child: new Icon(
//                      Ionicons.getIconData("ios-share"),
//                      color: Colors.black54,
//                    ),
//                  )),
//            ),

//            RaisedButton(
//              onPressed: () {
//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(builder: (context) => Checkout()),
//                );
//              },
//              textColor: Colors.white,
//              padding: const EdgeInsets.all(0.0),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(8.0),
//              ),
//              child: Container(
//
//                height: 60,
//                decoration: const BoxDecoration(
//                  gradient: LinearGradient(
//                    colors: <Color>[
//                      CustomColors.PurpleLight,
//                      CustomColors.PurpleDark,
//                    ],
//                  ),
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(8.0),
//                  ),
//                  boxShadow: [
//                    BoxShadow(
//                      color: CustomColors.PurpleShadow,
//                      blurRadius: 15.0,
//                      spreadRadius: 7.0,
//                      offset: Offset(0.0, 0.0),
//                    )
//                  ],
//                ),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//
//                    Icon(
//                      MaterialCommunityIcons.getIconData(
//                        "gift",
//                      ),
//                      color: Colors.white,
//                    ),
//                    new Text(
//                      "Buy Now",
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  ],
//                ),
//              ),
//            ),
                    SizedBox(
                      width: 6,
                    ),
                    ScopedModelDescendant<CartModel>(
                        builder: (context, child, model) {
                      return RaisedButton(
                        onPressed: () {
                          model.addProduct(_products[0]);
                          _alert(context);
                          setState(() {
                            isClicked = !isClicked;
                          });
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.9,
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            boxShadow: [],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // Icon(
                              //   MaterialCommunityIcons.getIconData(
                              //     "cart-outline",
                              //   ),
                              //   color: Colors.white,
                              // ),
                              new Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            )
          : Center(),
      body: _products != null
          ? NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    actions: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          isClicked
                              ? Positioned(
                                  left: 9,
                                  bottom: 13,
                                  child: Icon(
                                    Icons.looks_one,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                )
                              : Text(""),
                        ],
                      ),
                    ],
                    iconTheme: IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                    backgroundColor: Colors.white,
                    expandedHeight: MediaQuery.of(context).size.height / 2.4,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        "${_products[0].name}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      background: Padding(
                        padding: EdgeInsets.only(top: 48.0),
                        child: dottedSlider(_products[0]),
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildInfo(context, _products[0]), //Product Info
                      //_buildExtra(context),
                      _buildDescription(context, _products[0]),
                      _buildComments(context, _products[0]),
                      //_buildProducts(context),
                    ],
                  ),
                ),
              ),
            )
          :

          // Displaying LoadingSpinner to indicate waiting state
          Center(
              child: CircularProgressIndicator(),
            ),

      // Future that needs to be resolved
      // inorder to display something on the Canvas
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _alert(BuildContext context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.shrink,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
    );
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.success,
      title: "Shopping Cart",
      desc: "Your product has been added to cart.",
      buttons: [
        DialogButton(
          child: Text(
            "BACK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GO CART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cart()));
            Navigator.of(context, rootNavigator: true).pop();
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
    //debugPrint("Alert closed now.");
  }

  _productSlideImage(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(Network().imageget + "/" + imageUrl),
            fit: BoxFit.contain),
      ),
    );
  }

  dottedSlider(index) {
    return DottedSlider(
      maxHeight: 200,
      children: <Widget>[
        _productSlideImage(index.image),
        _productSlideImage(index.image),
        _productSlideImage(index.image),
        _productSlideImage(index.image),
      ],
    );
  }

  _buildDescription(BuildContext context, index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.8,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black45,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text("${index.description}"),
            SizedBox(
              height: 8,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context, index.description);
                },
                child: Text(
                  "View More",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildComments(BuildContext context, index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarRating(rating: 4, size: 20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "1250 Comments",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
              ),
              subtitle: Text(
                  "Cats are good pets, for they are clean and are not noisy."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "12 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.familiadejesusperu.org/images/avatar/john-doe-13.jpg"),
              ),
              subtitle: Text(
                  "There was no ice cream in the freezer, nor did they have money to go to the store."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "15 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1020903668240052225/_6uVaH4c.jpg"),
              ),
              subtitle: Text(
                  "I think I will buy the red car, or I will lease the blue one."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "25 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Similar Items",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTrending()
      ],
    );
  }

  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              // TrendingItem(
              //   product: Product(
              //       company: 'Apple',
              //       name: 'iPhone 7 plus (128GB)',
              //       icon: 'assets/iphone_7.png',
              //       rating: 4.5,
              //       remainingQuantity: 5,
              //       price: '\$2,000'),
              //   gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Apple',
              //       name: 'iPhone 11 (128GB)',
              //       icon: 'assets/phone1.jpeg',
              //       rating: 4.5,
              //       remainingQuantity: 5,
              //       price: '\$4,000'),
              //   gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'iPhone',
              //       name: 'iPhone 11 (64GB)',
              //       icon: 'assets/phone2.jpeg',
              //       rating: 4.5,
              //       price: '\$3,890'),
              //   gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Xiaomi',
              //       name: 'Xiaomi Redmi Note8',
              //       icon: 'assets/mi1.png',
              //       rating: 3.5,
              //       price: '\$2,890'),
              //   gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Apple',
              //       name: 'iPhone 11 (128GB)',
              //       icon: 'assets/phone1.jpeg',
              //       rating: 4.5,
              //       remainingQuantity: 5,
              //       price: '\$4,000'),
              //   gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'iPhone',
              //       name: 'iPhone 11 (64GB)',
              //       icon: 'assets/phone2.jpeg',
              //       rating: 4.5,
              //       price: '\$3,890'),
              //   gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Xiaomi',
              //       name: 'Xiaomi Redmi Note8',
              //       icon: 'assets/mi1.png',
              //       rating: 3.5,
              //       price: '\$2,890'),
              //   gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Apple',
              //       name: 'iPhone 11 (128GB)',
              //       icon: 'assets/phone1.jpeg',
              //       rating: 4.5,
              //       remainingQuantity: 5,
              //       price: '\$4,000'),
              //   gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'iPhone',
              //       name: 'iPhone 11 (64GB)',
              //       icon: 'assets/phone2.jpeg',
              //       rating: 4.5,
              //       price: '\$3,890'),
              //   gradientColors: [Color(0XFF6eed8c), Colors.green[400]],
              // ),
              // TrendingItem(
              //   product: Product(
              //       company: 'Xiaomi',
              //       name: 'Xiaomi Redmi Note8',
              //       icon: 'assets/mi1.png',
              //       rating: 3.5,
              //       price: '\$2,890'),
              //   gradientColors: [Color(0XFFf28767), Colors.orange[400]],
              // ),
            ],
          ),
        )
      ],
    );
  }
}

void _settingModalBottomSheet(context, des) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("{des}"),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      });
}

_buildInfo(context, index) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 130, child: Text("${index.sku}")),
              SizedBox(
                width: 48,
              ),
              Text("16 MP"),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(width: 130, child: Text("${index.slug}")),
              SizedBox(
                width: 48,
              ),
              Text("128 GB"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "Tüm Özellikler >",
              style: TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    ),
  );
}

_buildExtra(BuildContext context, index) {
  return Container(
    decoration: BoxDecoration(
        border: Border(
      top: BorderSide(width: 1.0, color: Colors.black12),
      bottom: BorderSide(width: 1.0, color: Colors.black12),
    )),
    padding: EdgeInsets.all(4.0),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 4,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Capacity"),
          Row(
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('64 GB'),
                onPressed: () {}, //callback when button is clicked
                borderSide: BorderSide(
                  color: Colors.grey, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 0.8, //width of the border
                ),
              ),
              SizedBox(
                width: 8,
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('128 GB'),
                onPressed: () {}, //callback when button is clicked
                borderSide: BorderSide(
                  color: Colors.red, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 1, //width of the border
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text("Color"),
          Row(
            children: <Widget>[
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('GOLD'),
                onPressed: () {}, //callback when button is clicked
                borderSide: BorderSide(
                  color: Colors.orangeAccent, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 1.5, //width of the border
                ),
              ),
              SizedBox(
                width: 8,
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('SILVER'),
                onPressed: () {}, //callback when button is clicked
                borderSide: BorderSide(
                  color: Colors.grey, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 0.8, //width of the border
                ),
              ),
              SizedBox(
                width: 8,
              ),
              OutlineButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8.0)),
                child: Text('PINK'),
                onPressed: () {}, //callback when button is clicked
                borderSide: BorderSide(
                  color: Colors.grey, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 0.8, //width of the border
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class DottedSlider extends StatefulWidget {
  final Color color;
  final List<Widget> children;
  final double maxHeight;
  DottedSlider({Key key, this.color, this.children, this.maxHeight})
      : super(key: key);

  @override
  _DottedSliderState createState() => new _DottedSliderState();
}

class _DottedSliderState extends State<DottedSlider> {
  PageController controller = PageController();

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: widget.maxHeight),
          child: PageView(
            controller: controller,
            children: widget.children,
          ),
        ),
        _drawDots(currentPage)
      ],
    );
  }

  _drawDots(page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < widget.children.length; i++) dot((page == i)),
      ],
    );
  }

  dot(bool selected) {
    double size = 6;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 2, left: 2, bottom: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selected) ? widget.color : Colors.black38),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  StarRating({this.rating, this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
        children: new List.generate(5, (index) => _buildStar(index, rating)));
  }

  _buildStar(int index, double rating) {
    IconData icon;
    Color color;
    if (index >= rating) {
      icon = Icons.star;
      color = Colors.grey;
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
      color = Colors.yellow;
    } else {
      icon = Icons.star;
      color = Colors.yellow;
    }
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
