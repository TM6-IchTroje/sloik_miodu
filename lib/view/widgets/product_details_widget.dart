import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/utils/view/screen_args/chat_route_args.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  final String name;
  final String description;
  final String link;
  final String ownerName;

  ProductDetailsWidget(
      {this.name, this.description, this.link, this.ownerName});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(height: 15.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(this.name,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 15.0),
      // -------------------------------- Product Image------------------------------- //
      Hero(
          tag: 12,
          child: Image.network(this.link,
              height: 150.0, width: 100.0, fit: BoxFit.contain)),
      SizedBox(height: 20.0),
      // -------------------------------- Product Price------------------------------- //
      Center(
        child: Text("15.99",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 10.0),
      // -------------------------------- Product Name ------------------------------- //
      Center(
        child: Text(this.name,
            style: TextStyle(
                color: Color(0xFF575E67),
                fontFamily: 'Varela',
                fontSize: 24.0)),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Product Description ------------------------------- //
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(this.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFFB4B8B9))),
        ),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- Btn Add To Cart------------------------------- //
      Center(
        child: GestureDetector(
          onTap: () {
            if (staticLogInState.email.compareTo(ownerName) != 0) {
              Firestore.instance
                  .collection("chats")
                  .where('p1', whereIn: [staticLogInState.email, ownerName])
                  .snapshots()
                  .first
                  .then((value) {
                    final doc = value.documents.where((e) =>
                        e['p2'].toString().compareTo(staticLogInState.email) ==
                            0 ||
                        e['p2'].toString().compareTo(ownerName) == 0);
                    if (doc.isNotEmpty) {
                      Navigator.pushNamed(
                        context,
                        chatRoute,
                        arguments: chatRouteArgs(
                            id: doc.first.documentID,
                            title: doc.first['p1'] == staticLogInState.email
                                ? doc.first['p2']
                                : doc.first['p1']),
                      );
                    } else {
                      Map<String, dynamic> data = new Map<String, dynamic>();
                      data['p1'] = staticLogInState.email;
                      data['p2'] = ownerName;
                      data['messages'] = [];
                      Firestore.instance
                          .collection("chats")
                          .add(data)
                          .then((value) {
                        Navigator.pushNamed(
                          context,
                          chatRoute,
                          arguments: chatRouteArgs(
                              id: value.documentID, title: ownerName),
                        );
                      });
                    }
                  });
            }
          },
          child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xFFF17532)),
              child: Center(
                  child: Text(
                'Napisz do sprzedawcy!',
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        ),
      ),
    ]);
  }
}
