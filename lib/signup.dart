import 'package:flutter/material.dart';
import 'package:sloik_miodu/logInScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class signup extends StatelessWidget {
  signup({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController pass1Controller = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                  TextFormField(
                    controller: pass1Controller,
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
                  TextFormField(
                    controller: pass2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Potwierdź hasło:",
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
                        child: Text("Zarejestruj się"),
                        color: Colors.white,
                        onPressed: (){
                          if (pass1Controller.text == pass2Controller.text) {
                            CollectionReference users = FirebaseFirestore
                                .instance.collection('users');

                            print(users);
                            users.add({
                              'email': emailController.text,
                              'password': pass1Controller.text
                            });
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>logInScreen()));
                        },
                        child: Text("Masz już konto? Zaloguj się!", style: TextStyle(
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
