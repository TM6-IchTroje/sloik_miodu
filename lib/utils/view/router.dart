import 'package:firebase_shop_app/main.dart';
import 'package:firebase_shop_app/utils/view/screen_args/chat_route_args.dart';
import 'package:firebase_shop_app/utils/view/screen_args/product_details_args.dart';
import 'package:firebase_shop_app/view/screens/all_products_screen.dart';
import 'package:firebase_shop_app/view/screens/blank_screen.dart';
import 'package:firebase_shop_app/view/screens/chat_screen.dart';
import 'package:firebase_shop_app/view/screens/my_products_screen.dart';
import 'package:firebase_shop_app/view/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/view/constant_routs.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chatRoute:
        chatRouteArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => chatScreen(
              id: args.id,
              title: args.title,
            )
        );
      case productDetailsRoute:
        ProductDetailsArgs args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(
                name: args.name,
                description: args.description,
                link: args.link,
                ownerName: args.ownerName,
                aboutOwner: args.aboutOwner,
                photo: args.photo,));
      case myProductsScreenRoute:
        return MaterialPageRoute(builder: (_) => MyProductsScreen());
      case allProductsScreenRoute:
        return MaterialPageRoute(builder: (_) => AllProductsScreen());
      case mainRoute:
        return MaterialPageRoute(builder: (_) => MyApp());
      default:
        return MaterialPageRoute(
          builder: (context) => BlankScreen(),
        );
    }
  }
}
