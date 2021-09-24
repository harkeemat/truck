import 'dart:convert';

import 'package:truck/model/ItemModel.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/service/sqlService.dart';
import 'package:truck/service/storageService.dart';
import 'package:truck/screen/my-globals.dart';

class ItemServices {
  SQLService sqlService = SQLService();
  StorageService storageService = StorageService();
  List<ShopItemModel> shoppingList = [];

// var data =() => {
//   var res;
//     globalisbrand == true
//         ? res = await Network().getData('/getproductbybrand/$globalbranname')
//         : globaliscategory == true
//             ? res = await Network().getData('/getproductBYcat/$globalbranname')
//             : globalisproduct == true
//                 ? res =
//                     await Network().getData('/getproductname/$globalbranname')
//                 : res = await Network().getData('/getproduct/$globalbrandid');

//     //var res = await Network().getData('/getproduct/$globalbrandid');

//     final jsonresponse = json.decode(res.body);

//     return jsonresponse['data'];
// }
  futurereturn() async {
    //int count = 1;
    //print(data);
    return await getdata();
    //print("data $data");
  }

  List<ShopItemModel> getShoppingItems() {
    int count = 1;
     var data = futurereturn();
    data.forEach((element) {
      print("data3 $element");
      element['id'] = count;
      shoppingList.add(ShopItemModel.fromJson(element));
      count++;
    });
    // print("data3 $shoppingList");
    //return shoppingList;
    //futurereturn();
    return shoppingList;
  }

  List<ShopItemModel> get items => getShoppingItems();

  Future openDB() async {
    return await sqlService.openDB();
  }

  loadItems() async {
    await storageService.deleteItem("isFirstTime");
    bool isFirst = await isFirstTime();

    if (isFirst) {
      // Load From local DB
      List items = await getLocalDBRecord();
      return items;
    } else {
      // Save Record into DB & load record
      List items = await saveToLocalDB();
      return items;
    }
  }

  Future<bool> isFirstTime() async {
    return await storageService.getItem("isFirstTime") == 'true';
  }

  Future saveToLocalDB() async {
    //print(this.items);
    List<ShopItemModel> items = this.items;
    for (var i = 0; i < items.length; i++) {
      await sqlService.saveRecord(items[i]);
    }
    storageService.setItem("isFirstTime", "true");
    return await getLocalDBRecord();
  }

  Future getLocalDBRecord() async {
    return await sqlService.getItemsRecord();
  }

  Future setItemAsFavourite(id, flag) async {
    return await sqlService.setItemAsFavourite(id, flag);
  }

  Future addToCart(ShopItemModel data) async {
    return await sqlService.addToCart(data);
  }

  Future addToQuntity(int id, int value) async {
    return await sqlService.addToQuntity(id, value);
  }

  Future getCartList() async {
    return await sqlService.getCartList();
  }

  removeFromCart(int shopId) async {
    return await sqlService.removeFromCart(shopId);
  }
}
