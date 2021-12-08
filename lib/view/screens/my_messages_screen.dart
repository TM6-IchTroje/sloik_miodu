import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:flutter/material.dart';

class MyMessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!staticLogInState.isLoggedIn) {
      return NoLogin();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Moje rozmowy"),
        ),
        body: BookList(),
      );
    }
  }
}

class NoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje rozmowy"),
      ),

      body: Center(
        child: TextButton(
          child: Text(
            "Zaloguj się, by przeglądać swoje rozmowy",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFA6442),
                fontWeight: FontWeight.normal),
          ),
          onPressed: () {
            staticLogInState.isLoggedIn = false;
            Navigator.pushNamed(context, '/logIn');
          },
        ),
      ),

      // ADD (Create)
    );
  }
}

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chats').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    if(document['p1'] == staticLogInState.email || document['p2'] == staticLogInState.email) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                        child: Card(
                          child: ListTile(
                            title: Text(document['p1'] == staticLogInState.email ? document['p2'] : document['p1'],
                                style: Theme.of(context).textTheme.headline6),
                            subtitle: Text(
                              document['messages'].last,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                      );
                      }
                    else
                      {
                        return Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0));
                      }
              }).toList(),
            );
        }
      },
    );
  }
}
