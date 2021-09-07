
class  NearByReasturantModel{

  static final reasturants=[
    ReaustrantItem("KFC", "An object that can be used to control","https://upload.wikimedia.org/wikipedia/en/thumb/b/bf/KFC_logo.svg/1200px-KFC_logo.svg.png"),
    ReaustrantItem("Pizza hut", "An object that can be used to control", "https://upload.wikimedia.org/wikipedia/sco/thumb/d/d2/Pizza_Hut_logo.svg/1088px-Pizza_Hut_logo.svg.png"),
    ReaustrantItem("Starbucks", "An object that can be used to control", "https://upload.wikimedia.org/wikipedia/en/thumb/d/d3/Starbucks_Corporation_Logo_2011.svg/1200px-Starbucks_Corporation_Logo_2011.svg.png"),
    ReaustrantItem("Mac Donal","An object that can be used to control", "https://www.beyondretailindustry.com/wp-content/uploads/2018/10/Logo-McDonalds.png"),
    ReaustrantItem("Burger king","An object that can be used to control", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Burger_King_2020.svg/1200px-Burger_King_2020.svg.png")];

}


class ReaustrantItem {
  final String name;
  final String desp;
  final String image;

  ReaustrantItem(this.name, this.desp,  this.image, );


}
