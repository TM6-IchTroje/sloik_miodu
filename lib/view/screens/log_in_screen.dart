import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class logInScreen extends StatelessWidget {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);


  Future<bool> checkLogin(TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      AuthResult userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(emailController.text);
    } catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      } else {
        return false;
      }
    }
    return true;
  }

  bool obserText = true;

  @override
  Widget build(BuildContext context) {

    void changeToMain(bool answer) {
      if (answer == true) {
        Navigator.pushNamed(context, '/MyApp');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Zaloguj się'),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrange,
      body: Form(
        key: _formKey,
        child: Container(
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
                    Text(
                      "Słoik miodu",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == "") {
                          return "Podaj email";
                        } else if (!regExp.hasMatch(value)) {
                          return "Email jest nieprawidłowy!";
                        }
                        return "";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obserText,
                      validator: (value) {
                        if (value == "") {
                          return "Podaj hasło";
                        } else if (value.length < 8) {
                          return "Hasło musi być dłuższe niż 8 znaków";
                        }
                        return "";
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Hasło:",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            // setState(() {
                            //   obserText = !obserText;
                            // });
                          },
                          child: Icon(
                            obserText == true
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                          onPressed: () {
                            checkLogin(_emailController, _passwordController)
                                .then(
                                  (value) => changeToMain(value),
                            );
                            //Navigator.pushNamed(context, '/allProductsScreen');
                          },
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signUp');
                          },
                          child: Text(
                            "Zarejestruj się!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }





}

