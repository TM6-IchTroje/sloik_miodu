import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/utils/view/constant_routs.dart';
import 'package:firebase_shop_app/utils/view/screen_args/product_details_args.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController linkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/Screenshot%202021-11-16%20at%2022.08.56.png?alt=media&token=b3d516af-5ffe-4a86-84b3-f2c012f15b14'),
        actions: [
          TextButton(
            child: Text('Zaloguj się'),
            onPressed: () {
              Navigator.pushNamed(context, '/logIn');
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          ),
        ],
      ),

      body: BookList(),
      // ADD (Create)
    );
  }
}

class BookList extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController linkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //TODO: Retrive all records in collection from Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('all_products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return new GridView(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items in row
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0, // Space between columns
                mainAxisSpacing: 15, // Space between rows
              ),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            productDetailsRoute,
                            arguments: ProductDetailsArgs(
                                name: document['name'],
                                description: document['description'],
                                link: document['link']),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.all(6.0),
                                  // -------------------------------- Favorite icon -------------------------------- //
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [])),
                              // -------------------------------- Product Image -------------------------------- //
                              Hero(
                                tag: document.hashCode,
                                child: Container(
                                  height: 150.0,
                                  width: 130.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(document['link']),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              // -------------------------------- Product price and title -------------------------------- //
                              Text(document['name'],
                                  style: TextStyle(
                                      color: Color(0xFFCC8053),
                                      fontFamily: 'Varela',
                                      fontSize: 14.0)),
                              Text(document['description'],
                                  style: TextStyle(
                                      color: Color(0xFF575E67),
                                      fontFamily: 'Varela',
                                      fontSize: 14.0)),
                              // -------------------------------- footer section (add to cart)------------------------------- //
                            ]))));
              }).toList(),
            );
        }
      },
    );
  }
}