import 'package:flutter/material.dart';
import 'package:truck/shop/screens/cart/cart_page.dart';
import 'package:truck/shop/screens/home/home.dart';
import 'package:truck/shop/screens/myAccount/myAccount.dart';
import 'package:truck/shop/screens/wishlist/wishList.dart';

//import 'package:food_app/utlis/routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  // static  TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List _widgetOptions = [
    Container(child: HomeScreen()),
    Container(child: Cart()),
    Container(child: WishList()),
    Container(child: MyAccount()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navigator.push(
        //                 context,
        //   MaterialPageRoute(builder: (context) => Profile()
        //   ),
        //   );
      }
      if (index == 1) {}
      if (index == 2) {}
      if (index == 3) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.white70,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Colors.white70,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
            backgroundColor: Colors.white70,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Account',
            backgroundColor: Colors.white70,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[600],
        // unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 26,
        elevation: 0,

        onTap: _onItemTapped,
      ),
    );
  }
}
