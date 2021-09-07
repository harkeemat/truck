

class TopPickForsModel {
  static final topPicks = [
    TopPickItems("Steam food", "",
        "https://static.toiimg.com/thumb/msid-78256113/78256113.jpg?width=500&resizemode=4"),
    TopPickItems("Steam food", "",
        "https://miro.medium.com/max/1838/1*0VJWT1lsnaKQwis7XdIcLA.jpeg"),
    TopPickItems("Steam food", "",
        "https://c8.alamy.com/comp/2BCPA40/pad-krapow-gai-thai-basil-chicken-with-rice-and-fried-egg-on-white-marble-background-pad-krapow-is-thai-cuisine-dish-with-minced-chicken-or-pork-me-2BCPA40.jpg"),
    TopPickItems("Steam food", "",
        "https://media.istockphoto.com/photos/most-famous-thai-foods-red-curry-pork-green-curry-pork-chicken-soup-picture-id1161110617?k=6&m=1161110617&s=612x612&w=0&h=HMOqA8ISLZZoiMyqbsFCkq-VtjMeZ-kqsbfpbLdYtdY=")
  ];
}

class TopPickItems {
  final String name;
  final String desp;
  final String image;

  TopPickItems(
    this.name,
    this.desp,
    this.image,
  );
}
