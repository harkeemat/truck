class Products {
  final List<Products> products;

  Products({this.products});

  factory Products.fromJson(List<dynamic> json) {
    List<Products> productList = json.map((i) => Products.fromJson(i)).toList();

    return Products(products: productList);
  }
}

class Product {
  int id;
  String name;
  String quantity;
  String slug;
  bool sale_price;
  String weight;
  String image;
  double price;
  bool isliked;
  bool isSelected;
  String category;
  Product(
      {this.id,
      this.name,
      this.quantity,
      this.sale_price,
      this.slug,
      this.weight,
      this.category,
      this.price,
      this.isliked,
      this.isSelected = false,
      this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      weight: json['weight'],
      sale_price: json['sale_price'],
      price: json['price'],
      slug: json['slug'],
    );
  }
}
