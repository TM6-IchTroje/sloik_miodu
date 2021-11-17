import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../signup.dart';


class logInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zaloguj się'),
      ),
      backgroundColor: Colors.deepOrange,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 500,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Słoik miodu", style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white)),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Hasło:",
                        suffixIcon: GestureDetector(
                          child: Icon(Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                        child: Text("Zaloguj się"),
                        color: Colors.white,
                        onPressed: (){}),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>signup()));
                        },
                        child: Text("Zarejestruj się!", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                      )

                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
