import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'log_in_screen.dart';

class signUp extends StatefulWidget {
  signUpState createState() => signUpState();
}

class signUpState extends State<signUp> {
  bool _passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController pass1Controller = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  String emailErr = "";
  String passErr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zarejestruj się'),
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
              child: Form(
                key: _formKey,
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
                      controller: emailController,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (emailErr.isNotEmpty) {
                          return emailErr;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: pass1Controller,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        hintText: "Hasło:",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          tooltip: 'Hide/Show password',
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (passErr.isNotEmpty) {
                          return passErr;
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: pass2Controller,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(),
                        hintText: "Potwierdź hasło:",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          tooltip: 'Hide/Show password',
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (value) {
                        if (pass1Controller.text != pass2Controller.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: RaisedButton(
                          child: Text("Zarejestruj się"),
                          color: Colors.white,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: pass1Controller.text);

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => logInScreen()));
                              } catch (e) {
                                print(e);
                                if (e.code == 'weak-password') {
                                  passErr = e.message;
                                } else {
                                  emailErr = e.message;
                                }
                              }
                              _formKey.currentState.validate();
                              passErr = emailErr = "";
                            }
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/logIn');
                          },
                          child: Text(
                            "Masz już konto? Zaloguj się!",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
