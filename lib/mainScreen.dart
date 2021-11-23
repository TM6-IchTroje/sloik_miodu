import 'package:flutter/material.dart';
import 'logInScreen.dart';
import 'login.dart';


class mainScreen extends StatelessWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.menu),onPressed:() {
          //
        }),
      title: Text("Słoik miodu"),
      actions: <Widget>[
        RaisedButton(
            child: Text("Zaloguj się!"),
            color: Colors.white,
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>logInScreen()),
              );
            })
      ],

      ),
    );
  }

}
