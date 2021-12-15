import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class myProductsContainerClass extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return myProductsList();
  }
}

class staticImage {
  static PickedFile imageFile;
  static String linkToImage =
      "https://firebasestorage.googleapis.com/v0/b/sloik-miodu-000.appspot.com/o/ffff.jpg?alt=media&token=e188d8c8-b06b-4f0b-abce-53d6108b49d4";
}

class MyProductsScreen extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController linkController = new TextEditingController();

  Future uploadImageToFirebase(BuildContext context) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    var reference = FirebaseStorage.instance.ref().child(formattedDate);
    StorageUploadTask uploadTask =
        reference.putFile(File(staticImage.imageFile.path));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    taskSnapshot.ref.getDownloadURL().then(
          (value) => staticImage.linkToImage = value,
        );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    staticImage.imageFile = pickedFile;
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Przeslij zdjęcie",
              style: TextStyle(color: Color(0xFFFA6442)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xFFFA6442),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Wybierz z galerii"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xFFFA6442),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!staticLogInState.isLoggedIn) {
      return NoLogin();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Moje ogłoszenia"),
        ),
        body: myProductsContainerClass(),
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
                        ),

                        MaterialButton(
                          color: Color(0xFFFA6442),
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                          child: Text("Wybierz zdjęcie"),
                        ),
                        Card(
                            child: Container(
                          height: 150,
                          child: (staticImage.imageFile == null)
                              ? Text("")
                              : Image.file(File(staticImage.imageFile.path)),
                        )),

                        //CameraWidgetState(),
                        // TextField(
                        //   controller: linkController,
                        // ),
                      ],
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
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
                          uploadImageToFirebase(context);

                          sleep(Duration(seconds: 2));

//TODO: Firestore create a new record code

                          Map<String, dynamic> newBook =
                              new Map<String, dynamic>();
                          newBook["name"] = nameController.text;
                          newBook["price"] = priceController.text;
                          newBook["description"] = descriptionController.text;
                          newBook["link"] = staticImage.linkToImage;
                          newBook["seller"] = staticLogInState.email;

                          Firestore.instance
                              .collection("all_products")
                              .add(newBook)
                              .whenComplete(() {
                            Navigator.of(context).pop();
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
}

class NoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moje ogłoszenia"),
      ),

      body: Center(
        child: TextButton(
          child: Text(
            "Zaloguj się, by przeglądać swoje produkty",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFFFA6442),
                fontWeight: FontWeight.normal),
          ),
          onPressed: () {
            staticLogInState.isLoggedIn = false;
            Navigator.pushNamed(context, '/logIn');
          },
        ),
      ),

      // ADD (Create)
    );
  }
}

class myProductsList extends State {
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
            return new ListView(
              padding: EdgeInsets.only(bottom: 80),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                if (document['seller'] == staticLogInState.email) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Card(
                      child: ListTile(
                        title: Text(document['name'],
                            style: Theme.of(context).textTheme.headline6),
                        subtitle: Text(
                          document['price'] + " zł",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
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

                                      //
                                      // TextField(
                                      //   controller: linkController,
                                      // ),
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
                                        updateBook["name"] =
                                            nameController.text;
                                        updateBook["price"] =
                                            priceController.text;
                                        updateBook["description"] =
                                            descriptionController.text;
                                        updateBook["link"] =
                                            linkController.text;

                                        // Updae Firestore record information regular way
                                        Firestore.instance
                                            .collection("all_products")
                                            .document(document.documentID)
                                            .updateData(updateBook)
                                            .whenComplete(() {
                                          Navigator.of(context).pop();
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
                } else {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0));
                }
              }).toList(),
            );
        }
      },
    );
  }
}
