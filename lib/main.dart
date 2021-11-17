import 'package:firebase_shop_app/core/providers/orders_provider.dart';
import 'package:firebase_shop_app/core/providers/product_model_provider.dart';
import 'package:firebase_shop_app/utils/view/theme_manager.dart';
import 'package:firebase_shop_app/view/screens/logInScreen.dart';
import 'package:firebase_shop_app/view/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './utils/view/constant_routs.dart';
import './utils/view/router.dart';
import './view/screens/products_overview_screen.dart';
import './core/providers/cart_provider.dart';
import './core/providers/products_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'core/providers/my_products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        // We can listen to these providers to any part of application
        // These providers Container not cause rebuild but the listeners
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: MyProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
//        ChangeNotifierProvider.value(value: ProductModelProvider()),
      ],
      child: MaterialApp(
        routes: {
          '/logIn': (ctx) => logInScreen(),
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        initialRoute: productsOverviewRoute,
        title: ThemeManager.appName,
        theme: ThemeManager.lightTheme,
        home: SharedBottomAppBar(),
      ),
    );
  }
}
