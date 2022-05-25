import 'package:flutter/material.dart';
import 'package:hungry_hour/home.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:hungry_hour/widgets/cart.dart';
import 'package:hungry_hour/widgets/favourites.dart';
import 'package:hungry_hour/widgets/user_form.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _indexPage = 0;
  final List<Widget> _page = [
    new HomePage(),
    new Cart(),
    new Favourites(),
    new User(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page.elementAt(_indexPage),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.white54,
        selectedIndex: _indexPage,
        onItemSelected: (value) {
          setState(() {
            _indexPage = value;
          });
        },
        //animationCurve: Curves.linear,
        //showElevation: true,
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home, color: Colors.black),
            title: const Text("Home",
                style: TextStyle(fontSize: 16.0, color: Colors.red)),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            title: const Text(
              "Cart",
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.favorite_outline_outlined,
                color: Colors.black),
            title: const Text("Favorites",
                style: TextStyle(fontSize: 16.0, color: Colors.red)),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person, color: Colors.black),
            title: const Text("Profile",
                style: TextStyle(fontSize: 16.0, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
