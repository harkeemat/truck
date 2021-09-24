
//  class CartModel{
//    static final products = [
//      CartItem("Burger", 10.0,"https://cdn.vox-cdn.com/thumbor/RzabiOl7nXsT1uVOlO0SxhSNDhg=/0x0:1117x521/1200x800/filters:focal(481x215:659x393)/cdn.vox-cdn.com/uploads/chorus_image/image/68758039/McPlant_Burger.0.png"),
//      CartItem("Strawberry",  10.0,"https://cdn.pixabay.com/photo/2016/04/15/08/04/strawberry-1330459__340.jpg")];
//  }

// class CartItem {
//   final String name;

//   final num price;
//   final String image;

//   CartItem(this.name, this.price, this.image, );


// }
class CartItem {
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

  CartItem({
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
}
