import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/screen/my-globals.dart';

getdata() async {
  var res;
  globalisbrand == true
      ? res = await Network().getData('/getproductbybrand/$globalbranname')
      : globaliscategory == true
          ? res = await Network().getData('/getproductBYcat/$globalbranname')
          : globalisproduct == true
              ? res = await Network().getData('/getproductname/$globalbranname')
              : res = await Network().getData('/getproduct/$globalbrandid');

  //var res = await Network().getData('/getproduct/$globalbrandid');

  final jsonresponse = json.decode(res.body);
  //print("data4 ${jsonresponse['data']}");
  return jsonresponse['data'];
}
// List productmodel;
// productcat() async {
//   var res = await Network().getData('/getproduct/$proid');

//   final jsonresponse = json.decode(res.body);
//   //print(jsonresponse['data']);
//   setState(() {
//     productmodel = jsonresponse['data'];
//   });

//   //final List<Item> foodCategoryList = jsonresponse['data'];
// }
 //var data = [
  // {
  //   "name": "lohapips",
  //   "brand_id": 8,
  //   "category_id": 3,
  //   "quantity": 1,
  //   "price": 220.1,
  //   "rating": 0.0,
  //   "fav": false,
  //   "image": "1631079094.jpg"
  // },
  // {
  //   "name": "lohapips",
  //   "brand_id": 8,
  //   "category_id": 3,
  //   "quantity": 1,
  //   "price": 220.1,
  //   "rating": 0.0,
  //   "fav": false,
  //   "image": "1631079094.jpg"
  // }

  // {
  //   "name": "Nike",
  //   "price": 25.00,
  //   "sale_price": 20.00,
  //   "brand_id": 8,
  //   "category_id": 3,
  //   "fav": false,
  //   "rating": 4.5,
  //   "quntity": 1,
  //   "description": "sdsdf dsfsd fdsf dsf ds fsd",
  //   "sku": "ds",
  //   "image":
  //       "https://rukminim1.flixcart.com/image/832/832/jao8uq80/shoe/3/r/q/sm323-9-sparx-white-original-imaezvxwmp6qz6tg.jpeg?q=70"
  // },
  // {
  //   "name": "Brasher Traveller Brasher Traveller ",
  //   "price": 200.00,
  //   "brand_id": 8,
  //   "category_id": 3,
  //   "fav": false,
  //   "rating": 4.5,
  //   "sale_price": 20.00,
  //   "description": "sdsdf dsfsd fdsf dsf ds fsd",
  //   "sku": "ds",
  //   "quntity": 1,
  //   "image":
  //       "https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/merrell_0.jpg?itok=wFRPiIPw"
  // },
  // {
  //   "name": "Brasher Traveller Brasher Traveller ",
  //   "price": 200.00,
  //   "brand_id": 8,
  //   "category_id": 3,
  //   "fav": false,
  //   "rating": 4.5,
  //   "sale_price": 20.00,
  //   "description": "sdsdf dsfsd fdsf dsf ds fsd",
  //   "sku": "ds",
  //   "quntity": 1,
  //   "image":
  //       "https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/merrell_0.jpg?itok=wFRPiIPw"
  // },
//];

class ShopItemModel {
  String name;
  double price;
  bool fav;
  double rating;
  String image;
  int id;
  int shopId;
  int quntity;
  int brandid;
  int categoryid;
  String sku;
  String description;
  double saleprice;

  ShopItemModel(
      {this.shopId,
      @required this.id,
      @required this.fav,
      @required this.rating,
      @required this.price,
      @required this.image,
      @required this.name,
      @required this.quntity,
      @required this.brandid,
      @required this.categoryid,
      @required this.description,
      @required this.saleprice,
      @required this.sku,
  });

  factory ShopItemModel.fromJson(Map<String, dynamic> json) {
    return ShopItemModel(
        id: json['id'],
        fav: json['fav'] == 1,
        rating: json['rating'] == null ? 0.0 : json['rating'],
        
        image: json['image'],
        name: json['name'],
        quntity: json['quntity'],
        shopId: json['shop_id'] ?? 0,
        brandid: json['brand_id'],
        categoryid: json['category_id'],
        description: json['description'],
        saleprice: json['sale_price'],
      price: json['price'],
      sku: json['sku'],
    );
  }
}
