import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModelProvider> _products = [
    ProductModelProvider(
      id: 'p1',
      title: 'Słoik miodu',
      description: 'Kup to gnoju!',
      price: 29.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/corpo-08112019_0003_c.jpg?alt=media&token=662d3f82-5ac8-4a7c-87d1-ffa32d9e2f29',
    ),
    ProductModelProvider(
        id: 'p2',
        title: 'Inny słoik',
        description: 'Zjadaj',
        price: 59.99,
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/24_1.jpg?alt=media&token=031ab6e3-4729-4cb1-8c06-27b10b4f37f9'),
    ProductModelProvider(
      id: 'p3',
      title: 'Słoik wpierniczanek',
      description: 'Bez opisu',
      price: 19.99,
      imageUrl:
          'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/CORPO-20082018_0004_zzzzzSQ-2633.jpg?alt=media&token=0d8c30aa-d704-46c9-b0c2-8a715ab39c1c',
    ),
    ProductModelProvider(
      id: 'p4',
      title: 'Czwarty słoik',
      description: 'pliska weź mnie',
      price: 78.99,
      imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/bombka-choinkowa-szklana-malowana-sloik-miodu.jpg?alt=media&token=f8807316-0b81-4b06-be21-a75ba4b14dab',
    ),
    ProductModelProvider(
        id: 'p5',
        title: 'Słoik spcjalny',
        description: 'Jedyny',
        price: 69.99,
        imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/sloik-miodu.png?alt=media&token=bac078d3-d182-455b-8f31-c452178803da'),
    ProductModelProvider(
      id: 'p6',
      title: 'Słoik zarąbisty',
      description: 'Wpierniczaj',
      price: 10.99,
      imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/Miod-z-JAGODA-900g-SLOIK-Z-KLAMRA.webp?alt=media&token=a7d7758a-3bc4-493d-8db8-1a6fbe9e549a',
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
        "https://flutter-shop-7ddca.firebaseio.com/products.json";
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
