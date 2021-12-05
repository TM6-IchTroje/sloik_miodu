import 'package:firebase_shop_app/utils/view/theme_manager.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:firebase_shop_app/view/screens/sign_up_screen.dart';
import 'package:firebase_shop_app/view/widgets/bottom_app_bar.dart';
import 'package:flutter/material.dart' hide Router;

import './utils/view/constant_routs.dart';
import './utils/view/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/logIn': (ctx) => logInScreen(),
        '/signUp': (ctx) => signUp(),
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router.generateRoute,
      initialRoute: productsOverviewRoute,
      title: ThemeManager.appName,
      theme: ThemeManager.lightTheme,
      home: SharedBottomAppBar(),
    );
  }
}
