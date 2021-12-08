import 'package:firebase_shop_app/view/widgets/pageview_widget.dart';
import 'package:firebase_shop_app/view/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String link;
  final String ownerName;
  final String aboutOwner;
  final String photo;

  ProductDetailsScreen({this.name, this.description, this.link, this.ownerName, this.aboutOwner, this.photo});

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
        body: PageView(
        children: <Widget>[
          PageViewWidget(number: AvailableNumber.First,name: this.name, description: this.description,
              link: this.link, ownerName: this.ownerName),
          PageViewWidget(number: AvailableNumber.Second,name: this.name, description: this.description,
              link: this.link, ownerName: this.ownerName, aboutOwner: this.aboutOwner, photo: this.photo)
        ]
      ),
    )
    );
  }
}
