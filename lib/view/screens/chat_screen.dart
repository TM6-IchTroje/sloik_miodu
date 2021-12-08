import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatelessWidget {
  final String id;

  chatScreen({this.id});

  @override
  Widget build(BuildContext context) {
    // Listen to specific object
    return Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey[600]),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [],
        ),
        body: BookList(id),
    )
    );
  }
}

class BookList extends StatelessWidget {
  String id;

  BookList(this.id);

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
            final dupa = snapshot.data.documents.where((d) => d.documentID == this.id).first['messages'];
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children:
                [
                  for (int i=0;i<dupa.length;++i)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                      child: ListTile(
                        title: Text(dupa[i],
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ),
                  )
                ]
            );
        }
      },
    );
  }
}
