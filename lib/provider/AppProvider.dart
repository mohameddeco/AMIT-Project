import 'package:amit_project/screens/All_Products.dart';
import 'package:amit_project/screens/menu_screen.dart';
import 'package:amit_project/screens/user.Cart.dart';
import 'package:amit_project/screens/user_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier{

  int currentIndex=0;
  List<BottomNavigationBarItem> navList=[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Menu',
    ),
  ];
  List<Widget> screens=[
    AllProducts(),
    UserCategories(),
    UserCart(),
    MenuScreen()
  ];

  ChangeIndex(index){
    currentIndex=index;
    notifyListeners();
  }

}