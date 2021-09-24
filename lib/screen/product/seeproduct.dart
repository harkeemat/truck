import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:truck/model/cartmodel.dart';
import 'package:truck/network_utils/api.dart';

import 'package:truck/screen/product/product_detail.dart';

class Allproduct extends StatefulWidget {
  final brandname;
  Allproduct({Key key, this.brandname}) : super(key: key);
  @override
  _AllproductState createState() => _AllproductState(brandname: this.brandname);
}

class _AllproductState extends State<Allproduct> {
  final brandname;
  _AllproductState({this.brandname});
  List _products;
  List test;

  fetchData() async {
    print(brandname);
    var res;
    brandname['id'] != null
        ? res = await Network().getData('/getproduct/${brandname['id']}')
        : res = await Network()
            .getData('/${brandname['brandname']}/${brandname['searchby']}');

    //var res = await Network().getData('/getproduct/$globalbrandid');

    final jsonResponse = json.decode(res.body);

    //   _products = jsonResponse['data']
    //       .map((data) => new Product.fromJson(data))
    //       .toList();
    //
    print(jsonResponse);
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
        );
      }).toList();
      //print(test[0].name);
      //_products.add(test);
      // print(_products);
    });

    //_products = jsonresponse['data'];

    //return jsonresponse['data'];
  }

  @override
  void initState() {
    fetchData();
    //print(_products);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],

      body: _products != null
          ? GridView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _products.length == null ? 0 : _products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return ScopedModelDescendant<CartModel>(
                    builder: (context, child, model) {
                  //print("pro${_products[index].id}");
                  return Card(
                      child: Column(children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemDetailPage(
                                    itemId: _products[index].id)));
                      },
                      child: Image.network(
                        Network().imageget + "/" + _products[index].image,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Text(
                      _products[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("\$" + _products[index].price.toString()),
                    OutlineButton(
                        child: Text("Add"),
                        onPressed: () => model.addProduct(_products[index]))
                  ]));
                });
              },
            )
          : Center(child: CircularProgressIndicator()),

      // ListView.builder(
      //   itemExtent: 80,
      //   itemCount: _products.length,
      //   itemBuilder: (context, index) {
      //     return ScopedModelDescendant<CartModel>(
      //         builder: (context, child, model) {
      //       return ListTile(
      //           leading: Image.network(_products[index].imgUrl),
      //           title: Text(_products[index].title),
      //           subtitle: Text("\$"+_products[index].price.toString()),
      //           trailing: OutlineButton(
      //               child: Text("Add"),
      //               onPressed: () => model.addProduct(_products[index])));
      //     });
      //   },
      // ),
    );
  }
}
