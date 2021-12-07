import 'package:flutter/material.dart';

class AboutUserWidget extends StatelessWidget {
  final String name;
  final String description;
  final String link;
  final String nameOwner;

  AboutUserWidget({ this.name, this.description, this.link, this.nameOwner});
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
    ],

    );
  }

}