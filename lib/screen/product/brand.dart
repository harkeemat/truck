import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:truck/controller/homePageController.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';

import 'package:truck/screen/product/product.dart';
import 'package:truck/screen/product/shoping_cart_page.dart';

import 'package:truck/theme/light_color.dart';
import 'package:truck/theme/theme.dart';

import 'package:truck/widget/title_text.dart';

class Brand extends StatefulWidget {
  Brand({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BrandState createState() => _BrandState();
}

class _BrandState extends State<Brand> {
  List brandmodel;

  final HomePageController controller = Get.put(HomePageController());
  brandcat() async {
    var res = await Network().getData('/getbrand/');

    final jsonresponse = json.decode(res.body);
    //print(jsonresponse['data']);
    setState(() {
      brandmodel = jsonresponse['data'];
    });

    //final List<Item> foodCategoryList = jsonresponse['data'];
  }

  bool isHomePageSelected = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset("assets/user.png"),
            ),
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: isHomePageSelected ? 'All' : 'Shopping',
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
                TitleText(
                  text: isHomePageSelected ? 'Brand' : 'Cart',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            Spacer(),
            !isHomePageSelected
                ? Icon(
                    Icons.delete_outline,
                    color: LightColor.orange,
                  )
                : SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  @override
  void initState() {
    brandcat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shops"),
        elevation: 0.0,
        backgroundColor: globalColor,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: InkResponse(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: Stack(
                  children: [
                    GetBuilder<HomePageController>(
                        builder: (_) => Align(
                              child: Text(controller.cartItems.length > 0
                                  ? controller.cartItems.length.toString()
                                  : ''),
                              alignment: Alignment.topLeft,
                            )),
                    Align(
                      child: Icon(Icons.shopping_cart),
                      alignment: Alignment.center,
                    ),
                  ],
                )),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Color(0xfffbfbfb),
                    Color(0xfff7f7f7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInToLinear,
                      switchOutCurve: Curves.easeOutBack,
                      child: brandmodel != null
                          ? GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 10.7 / 11,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 10),
                              itemCount:
                                  brandmodel == null ? 0 : brandmodel.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final brand = brandmodel[index];
                                return brands(brand);
                              })
                          : Center(child: CircularProgressIndicator()),
                    ))
                  ],
                ),
              ),
            ),
            // Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: CustomBottomNavigationBar(
            //       onIconPresedCallback: onBottomIconPressed,
            //     ))
          ],
        ),
      ),
    );
  }
Widget brands(item) {
    //print("dfdf${item['logo']}");
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      
                      margin: EdgeInsets.all(6.0),
                      child: Image.network(
                          Network().imageget + "/" + item['logo'],
                          fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
  Widget branddata(brand) {
    return InkWell(
      onTap: () {
        globalbrandid = brand['id'];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Product(brandname: {
                      "brandname": null,
                      "searchby": null,
                      "id": brand['id']
                    })));
      },
      child: Card(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(Network().imageget + "/" + brand['logo'],
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
