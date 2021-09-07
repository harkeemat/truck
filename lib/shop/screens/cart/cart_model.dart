
 class CartModel{
   static final products = [
     CartItem("Burger", 10.0,"https://cdn.vox-cdn.com/thumbor/RzabiOl7nXsT1uVOlO0SxhSNDhg=/0x0:1117x521/1200x800/filters:focal(481x215:659x393)/cdn.vox-cdn.com/uploads/chorus_image/image/68758039/McPlant_Burger.0.png"),
     CartItem("Strawberry",  10.0,"https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberry-1330459__340.jpg")];
 }

class CartItem {
  final String name;

  final num price;
  final String image;

  CartItem(this.name, this.price, this.image, );


}