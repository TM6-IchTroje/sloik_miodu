import 'package:flutter/material.dart';

class AboutUserWidget extends StatelessWidget {
  final String name;
  final String ownerName;
  final String aboutOwner;
  final String photo;
  String photo2="https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/pszczelarz1.jpg?alt=media&token=2959601b-a86e-4cb2-bf3a-6fa710ed510e";
  AboutUserWidget({ this.name, this.ownerName, this.aboutOwner, this.photo});
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(height: 15.0),
      Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text("O wystawiającym",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 42.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      SizedBox(height: 15.0),
      // -------------------------------- Seller Name------------------------------- //
      Center(
        child: Text(this.ownerName,
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))),
      ),
      // -------------------------------- Seller Photo------------------------------- //
      Center(
        child: Container(
          height: 150.0,
          width: 130.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(this.photo),
                fit: BoxFit.contain),
          ),
        ),
      ),
      // -------------------------------- About Seller------------------------------- //
      Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Text("Coś o mnie:",
          style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFF17532))
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(this.aboutOwner,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFF575E67))),
        ),
      ),
      SizedBox(height: 20.0),
      // -------------------------------- OPINION------------------------------- //
      Container(
        padding: EdgeInsets.only(left: 20.0),
        child: Text("Opinie użytkownika",
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF17532))
        ),
      ),

    ],

    );
  }

}