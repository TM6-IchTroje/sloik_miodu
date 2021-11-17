import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:flutter/material.dart';

class MyProductsProvider with ChangeNotifier {
  List<ProductModelProvider> _products = [
    ProductModelProvider(
      id: 'p1',
      title: 'Mój słoik',
      description: 'Opis',
      price: 65.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/corpo-08112019_0003_c.jpg?alt=media&token=662d3f82-5ac8-4a7c-87d1-ffa32d9e2f29',
    ),
  ];

  // getter
  //  List<Product> get products => [..._products];
  List<ProductModelProvider> get products {
    return _products;
  }

  List<ProductModelProvider> get favoriteProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(ProductModelProvider product) {
    const String url =
        "";
    return http
        .post(Uri.parse(url),
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite,
            }))
        .then((response) {
      _products.add(product);

      notifyListeners();
    }).catchError((err) {
      // Print Something ...
    });
  }

  void updateProduct(String id, ProductModelProvider product) {
    final productIndex = _products.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      _products[productIndex] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

  ProductModelProvider findProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void addProductToFavourite(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    if (product.isFavorite == false) {
      product.isFavorite = true;
      notifyListeners();
    }
  }

  void removeProductFromFavourite(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    if (product.isFavorite) {
      product.isFavorite = false;
      notifyListeners();
    }
  }
}
