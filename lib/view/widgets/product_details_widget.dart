import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  final String name;
  final String description;
  final String link;

  ProductDetailsWidget({this.name, this.description, this.link});

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
    ]);
  }
}
