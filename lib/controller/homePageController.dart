import 'package:get/get.dart';
import 'package:truck/model/ItemModel.dart';
import 'package:truck/service/itemService.dart';

class HomePageController extends GetxController {
  final brandid;
  HomePageController({this.brandid});

  ItemServices itemServices = ItemServices();
  List<ShopItemModel> items = [];
  List<ShopItemModel> cartItems = [];
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //print(brandid);
    loadDB();
  }

  loadDB() async {
    await itemServices.openDB();
    loadItems();
    getCardList();
  }

  getItem(int id) {
    return items.singleWhere((element) => element.id == id);
  }

  bool isAlreadyInCart(id) {
    return cartItems.indexWhere((element) => element.shopId == id) > -1;
  }

  getCardList() async {
    try {
      List list = await itemServices.getCartList();
      cartItems.clear();
      list.forEach((element) {
        cartItems.add(ShopItemModel.fromJson(element));
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  loadItems() async {
    try {
      isLoading = true;
      update();

      List list = await itemServices.loadItems();
      list.forEach((element) {
        items.add(ShopItemModel.fromJson(element));
      });

      isLoading = false;
      update();
    } catch (e) {
      print(e);
    }
  }

  setToFav(int id, bool flag) async {
    int index = items.indexWhere((element) => element.id == id);

    items[index].fav = flag;
    update();
    try {
      await itemServices.setItemAsFavourite(id, flag);
    } catch (e) {
      print(e);
    }
  }

  Future addToCart(ShopItemModel item) async {
    isLoading = true;
    update();
    var result = await itemServices.addToCart(item);
    isLoading = false;
    update();
    return result;
  }

  Future addToQuntity(int id, int value) async {
    isLoading = true;
    update();
    var result = await itemServices.addToQuntity(id, value);
    isLoading = false;
    update();
    return result;
  }

  removeFromCart(int shopId) async {
    itemServices.removeFromCart(shopId);
    int index = cartItems.indexWhere((element) => element.shopId == shopId);
    cartItems.removeAt(index);
    update();
  }
}
