import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/core/providers/products_provider.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/view/shared/badge.dart';
import 'package:firebase_shop_app/view/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;
  final int index;

  ProductDetailsScreen({this.productId, this.index});
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findProductById(productId);

    // Listen to specific object
    return ChangeNotifierProvider.value(
      value: loadedProduct,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
          ],
        ),
        body: ProductDetailsWidget(product: loadedProduct, index: index),
      ),
    );
  }
}
