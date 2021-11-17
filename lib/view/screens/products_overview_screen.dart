import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/products_provider.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/view/shared/badge.dart';
import 'package:firebase_shop_app/view/widgets/bottom_app_bar.dart';
import 'package:firebase_shop_app/view/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blank_screen.dart';


enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavouriteOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Image.network('https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/Screenshot%202021-11-16%20at%2022.08.56.png?alt=media&token=b3d516af-5ffe-4a86-84b3-f2c012f15b14'),
        actions: [
         TextButton(
              child: Text('Zaloguj się'),


              onPressed: () {
                BlankScreen();
                Navigator.pushNamed(context, '/logIn');
              },
           style: TextButton.styleFrom(
             primary: Colors.white,
           ),

            ),

        ],
      ),
      body: ProductsGrid(_showFavouriteOnly),
    );
  }
}
