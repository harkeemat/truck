import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:truck/shop/screens/wishlist/wishlist_model.dart';
import 'package:truck/shop/utlis/platte.dart';
import 'package:truck/shop/widgets/gradient_color.dart';

class WishList extends StatelessWidget {
  const WishList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.red,),
        //       onPressed: () {
        //         Navigator.push( context, MaterialPageRoute(builder: (context) => BottomNavBar()),);
        //       }),
        //   //backgroundColor: Colors.black.withOpacity(0.0),
        //   elevation: 0.0,
        //   title: Text("My Wishlist",style: kBodyNrmlRedText,),
        //
        // ),
        body: ListView(
      children: [
        Column(
          children: [
            SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Stack(
                  children: [
                    GradientColor(
                      image: 'assets/images/pic1.jpg',
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: Icon(Icons.arrow_back_ios_rounded,
                                    size: 18, color: Colors.red[500]),
                              ),
                            ),
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: Icon(CupertinoIcons.heart_fill,
                                    size: 18, color: Colors.red[500]),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
                    child: Container(
                      child: Text(
                        "Favourite Restaurants",
                        style: ksmallBlackText,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: (WishlistModel.wishListData.isNotEmpty)
                  ? ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      // physics: ClampingScrollPhysics(),
                      itemCount: WishlistModel.wishListData.length,
                      itemBuilder: (BuildContext context, int index) =>
                          WishListItemData(
                              item: WishlistModel.wishListData[index]))
                  : CircularProgressIndicator(),
            )
          ],
        )
      ],
    ));
  }
}

class WishListItemData extends StatelessWidget {
  final WishlistItem item;

  const WishListItemData({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  height: 80,
                  width: 120,
                  margin: EdgeInsets.all(6.0),
                  child: Image.network(item.image, fit: BoxFit.cover)),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            item.name,
                            style: kBodyNrmlRedText,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Desert sweet icecream",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
