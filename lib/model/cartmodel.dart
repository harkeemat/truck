import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<Product> cart = [];
  double totalCartValue = 0;
  double totalCartValueget = 0;
  double saletotalCartValue = 0;

  int get total => cart.length;

  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    //print(index);
    if (index != -1)
      updateProduct(product, product.qty + 1);
    else {
      cart.add(product);
      calculateTotal();
      //calculatesaleTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    //calculatesaleTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = qty;
    if (cart[index].qty == 0) removeProduct(product);

    calculateTotal();
    //calculatesaleTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValueget = 0;
    cart.forEach((f) {
      totalCartValueget += double.parse(f.price) * f.qty;
    });
    totalCartValue = getNumber(totalCartValueget, precision: 1);
    // cart.forEach((f) {
    //   saletotalCartValue += double.parse(f.saleprice) * f.qty;
    // });
  }

  double getNumber(double input, {int precision = 2}) => double.parse(
      '$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  // void calculatesaleTotal() {
  //   saletotalCartValue = 0;
  //   cart.forEach((f) {
  //     saletotalCartValue += double.parse(f.saleprice) * f.qty;
  //   });
  // }
}

class Product {
  final int id;
  final String name;
  final String image;
  final String price;
  final int brandid;
  final String categoryid;
  final String sku;
  final String slug;
  final String description;
  int qty;
  final String weight;
  final String rating;

  final bool fav;
  final String saleprice;
  // Product(
  //     int id,
  //     String name,
  //     String image,
  //     int quantity,
  //     double saleprice,
  //     int brandid,
  //     int categoryid,
  //     String sku,
  //     String slug,
  //     String description,
  //     double weight,
  //     double rating,
  //     bool fav) {
  //   this.id = id;
  //   this.name = name;
  //   this.quantity = quantity;
  //   this.image = image;
  //   this.saleprice = saleprice;
  //   this.brandid = brandid;
  //   this.categoryid = categoryid;
  //   this.sku = sku;
  //   this.slug = slug;
  //   this.description = description;
  //   this.weight = weight;
  //   this.rating = rating;
  //   this.fav = fav;
  // }
  Product({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.image,
    this.saleprice,
    this.brandid,
    this.categoryid,
    this.sku,
    this.slug,
    this.description,
    this.weight,
    this.rating,
    this.fav,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      qty: json['quantity'],
      price: json['price'],
      saleprice: json['sale_price'],
      brandid: json['brand_id'],
      categoryid: json['category_id'],
      sku: json['sku'],
      slug: json['slug'],
      description: json['description'],
      weight: json['weight'],
      rating: json['rating'],
      fav: json['fav'],
    );
  }
  // Product.fromJson(Map json)
  //     : id = json['id'],
  //       name = json['name'],
  //       image = json['image'],
  //       quantity = json['quantity'],
  //       saleprice = json['sale_price'],
  //       brandid = json['brand_id'],
  //       categoryid = json['category_id'],
  //       sku = json['sku'],
  //       slug = json['slug'],
  //       description = json['description'],
  //       weight = json['weight'],
  //       rating = json['rating'],
  //       fav = json['fav'];

  // Map toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'image': image,
  //     'saleprice': saleprice,
  //     'brandid': brandid,
  //     'categoryid': categoryid,
  //     'sku': sku,
  //     'slug': slug,
  //     'description': description,
  //     'weight': weight,
  //     'rating': rating,
  //     'fav': fav,
  //     'quantity': quantity
  //   };
  // }
}
