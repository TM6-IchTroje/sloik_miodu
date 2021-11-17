import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/utils/view/screen_args/product_details_args.dart';
import 'package:firebase_shop_app/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final index;

  ProductGridItem(this.index);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductModelProvider>(context, listen: false);

    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                productDetailsRoute,
                arguments: ProductDetailsArgs(id: product.id, index: index),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      // -------------------------------- Favorite icon -------------------------------- //
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                          ])),
                  // -------------------------------- Product Image -------------------------------- //
                  Hero(
                    tag: 'tage$index',
                    child: Container(
                      height: 150.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  // -------------------------------- Product price and title -------------------------------- //
                  Text(product.price.toString(),
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Text(product.title,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  // -------------------------------- footer section (add to cart)------------------------------- //
                ]))));
  }
}
