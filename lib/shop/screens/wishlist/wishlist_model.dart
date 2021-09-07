


class  WishlistModel{
  static  final wishListData  = [
    WishlistItem("Katani restaurant", "", 10.0,"https://images.unsplash.com/photo-1559339352-11d035aa65de?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aG90ZWwlMjByZXN0YXVyYW50fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
    WishlistItem("Armit restaurant", "", 10.0,"https://www.linguahouse.com/linguafiles/md5/d01dfa8621f83289155a3be0970fb0cb"),
    WishlistItem("Garden house restaurant", "", 10.0,"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3Tx6kc4gN0wRIxzCG6ZWi47Pqpdu6c5mpGg&usqp=CAU"),
    WishlistItem("Victoria restaurant", "", 10.0,"https://m.fourseasons.com/alt/img-opt/~70.1530.0,0000-772,5000-3000,0000-1687,5000/publish/content/dam/fourseasons/images/web/MUM/MUM_373_original.jpg"),
    WishlistItem("Panjabi restaurant", "", 10.0,"https://media-cdn.tripadvisor.com/media/photo-s/03/ce/f3/e7/san-qi.jpg"),
    WishlistItem("Mohangi restaurant", "", 10.0,"https://res.cloudinary.com/simplotel/image/upload/w_5000,h_3333/x_0,y_260,w_5000,h_2813,r_0,c_crop,q_80,fl_progressive/w_400,f_auto,c_fit/hotel-daspalla-vishakhapatnam/Vaisakhi_Restaurant_at_Hotel_Daspalla_Vishakhapatnam_2_xirfdk"),
  ];

}

class WishlistItem {
  final String name;
  final String desp;
  final num price;
  final String image;

  WishlistItem(this.name, this.desp, this.price, this.image, );


}