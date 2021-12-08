import 'package:firebase_shop_app/view/screens/all_products_screen.dart';
import 'package:firebase_shop_app/view/screens/blank_screen.dart';
import 'package:firebase_shop_app/view/screens/my_products_screen.dart';
import 'package:firebase_shop_app/view/shared/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class SharedBottomAppBar extends StatefulWidget {
  @override
  _SharedBottomAppBarState createState() => _SharedBottomAppBarState();
}

class _SharedBottomAppBarState extends State<SharedBottomAppBar> {
  Widget _lastSelected = AllProductsScreen();

  List<Widget> pages = [
    BlankScreen(),
    MyProductsScreen(),
    AllProductsScreen(),
  ];
  List<String> titles = ['Wiadomości', 'Wystaw produkt', 'Strona główna'];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _lastSelected,
      bottomNavigationBar: CustomBottomAppBar(
        color: Colors.grey,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          BottomAppBarItem(iconData: Icons.message, text: 'Wiadomości'),
          BottomAppBarItem(iconData: Icons.add, text: 'Wystaw produkt'),
          BottomAppBarItem(iconData: Icons.home, text: 'Strona główna'),
        ],
      ),
    );
  }
}
