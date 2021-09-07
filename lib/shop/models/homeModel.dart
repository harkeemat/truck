//import 'dart:convert';

class CatelogModel {
  // ignore: non_constant_identifier_names
  static final Products = [
    Item("Food", "An object that can be used to control", 10.0,"https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg"),
    Item("bhular", "An object that can be used to control", 10.0,
        "https://cdn.pixabay.com/photo/2017/07/28/14/29/macarons-2548827__340.jpg"),
    Item("test", "An object that can be used to control", 10.0,
        "https://cdn.pixabay.com/photo/2017/11/08/22/18/spaghetti-2931846__340.jpg"),
    Item("Sunil", "An object that can be used to control", 10.0,"https://cdn.pixabay.com/photo/2018/04/29/11/54/strawberries-3359755__340.jpg"),
    Item("ramm", "An object that can be used to control", 10.0,
        "https://cdn.pixabay.com/photo/2017/07/28/14/29/macarons-2548827__340.jpg"),
    Item("amn", "An object that can be used to control", 10.0,
        "https://cdn.pixabay.com/photo/2017/11/08/22/18/spaghetti-2931846__340.jpg"),
    Item("Neera", "An object that can be used to control", 10.0,"https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberry-1330459__340.jpg")];


}
class Item {
  final String name;
  final String desp;
  final num price;
  final String image;


  Item(this.name, this.desp, this.price, this.image, );


}





