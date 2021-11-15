import 'package:flutter/material.dart';
import 'mainScreen.dart';

class logInScreen extends StatelessWidget {
  const logInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEF642D)),
      home: Material(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  child: Row(
                    children: <Widget>[
                      Text("Zarejestruj się!",
                      style: TextStyle(
                        color: Colors.white
                      ),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),

      ),
    );
  }
}
