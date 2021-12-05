import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyProductsScreen extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController linkController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje ogłoszenia"),
      ),
      body: BookList(),
      // ADD (Create)

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Dodaj ogłoszenie"),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Nazwa: ",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      TextField(
                        controller: nameController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Cena: "),
                      ),
                      TextField(
                        controller: priceController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Opis: ",
                          textAlign: TextAlign.start,
                        ),
                      ),
                      TextField(
                        controller: descriptionController,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Link: "),
                      ),
                      TextField(
                        controller: linkController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cofnij",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    //Add Button

                    RaisedButton(
                      onPressed: () {
//TODO: Firestore create a new record code

                        Map<String, dynamic> newBook =
                            new Map<String, dynamic>();
                        newBook["name"] = nameController.text;
                        newBook["price"] = priceController.text;
                        newBook["description"] = descriptionController.text;
                        newBook["link"] = linkController.text;

                        Firestore.instance
                            .collection("user_products")
                            .add(newBook)
                            .whenComplete(() {
                          Navigator.of(context).pop();
                        });

                        Firestore.instance
                            .collection("all_products")
                            .add(newBook)
                            .whenComplete(() {
                        });
                      },
                      child: Text(
                        "Zapisz",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add Title',
        child: Icon(Icons.add),
      ),
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
      stream: Firestore.instance.collection('user_products').snapshots(),
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
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Card(
                    child: ListTile(
                      title: Text(document['name'],
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(
                        document['description'],
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(document['link']),
                        radius: 24,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Uaktualnij ofertę"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Dodaj ogłoszenie"),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Nazwa: ",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    TextField(
                                      controller: nameController,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text("Cena: "),
                                    ),
                                    TextField(
                                      controller: priceController,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Opis: ",
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    TextField(
                                      controller: descriptionController,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text("Link: "),
                                    ),
                                    TextField(
                                      controller: linkController,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: RaisedButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cofnij",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // Update Button
                                  RaisedButton(
                                    onPressed: () {
                                      //TODO: Firestore update a record code

                                      Map<String, dynamic> updateBook =
                                          new Map<String, dynamic>();
                                      updateBook["name"] = nameController.text;
                                      updateBook["price"] =
                                          priceController.text;
                                      updateBook["description"] =
                                          descriptionController.text;
                                      updateBook["link"] = linkController.text;

                                      // Updae Firestore record information regular way
                                      Firestore.instance
                                          .collection("user_products")
                                          .document(document.documentID)
                                          .updateData(updateBook)
                                          .whenComplete(() {
                                        Navigator.of(context).pop();
                                      });

                                      Firestore.instance
                                          .collection("all_products")
                                          .document(document.documentID)
                                          .updateData(updateBook)
                                          .whenComplete(() {
                                      });
                                    },
                                    child: Text(
                                      "Uaktualnij",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      trailing:
                          // Delete Button
                          InkWell(
                        onTap: () {
                          //TODO: Firestore delete a record code
                          Firestore.instance
                              .collection("user_products")
                              .document(document.documentID)
                              .delete()
                              .catchError((e) {
                            print(e);
                          });

                          Firestore.instance
                              .collection("all_products")
                              .document(document.documentID)
                              .delete()
                              .catchError((e) {
                            print(e);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
