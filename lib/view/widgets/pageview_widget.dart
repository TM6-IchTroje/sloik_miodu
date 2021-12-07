import 'package:firebase_shop_app/view/widgets/about_user_widget.dart';
import 'package:firebase_shop_app/view/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatelessWidget {
  final AvailableNumber number;
  final String name;
  final String description;
  final String link;
  final String nameOwner;

  PageViewWidget(
      {this.number, this.name, this.description, this.link, this.nameOwner});

  @override
  Widget build(BuildContext context) {
    if (number == AvailableNumber.First) {
    return ProductDetailsWidget(name: this.name, description: this.description, link: this.link);
    }
    else {
      return AboutUserWidget(name: this.name, description: this.description, link: this.link);
    }

  }


}
enum AvailableNumber{First, Second}