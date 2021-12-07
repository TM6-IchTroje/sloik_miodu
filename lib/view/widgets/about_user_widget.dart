import 'package:flutter/material.dart';

class AboutUserWidget extends StatelessWidget {
  final String name;
  final String ownerName;
  String aboutOwner = "Pasjonuje się zajadaniem pysznego miodku, dlatego postanowiłem już w 2004 zająć się pasieką. Mam 8 milionów pszczół. ";
  AboutUserWidget({ this.name, this.ownerName});
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
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 50.0,
          child: Text(aboutOwner,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                  color: Color(0xFFB4B8B9))),
        ),
      ),
      SizedBox(height: 20.0),
    ],

    );
  }

}