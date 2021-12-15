import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shop_app/view/screens/log_in_screen.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatelessWidget {
  final String id;
  final String title;
  final textFieldController = TextEditingController();

  chatScreen({this.id, this.title});

  @override
  Widget build(BuildContext context) {
    // Listen to specific object
    return Padding(
      padding: EdgeInsets.only(left: 0.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.deepOrangeAccent,
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
        body: conversationList(id),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 30),
          child: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: 'Wpisz wiadomość'),
            maxLines: 1,
            onSubmitted: (m) {
              if (m.isNotEmpty) {

                Firestore.instance.collection("chats").document(id).updateData({
                  "messages": FieldValue.arrayUnion([
                    staticLogInState.email + "> " + textFieldController.text
                  ]),
                }).whenComplete(() => (context as Element).reassemble());
                textFieldController.text = "";
              }
            },
          ),
        ),
      ),
    );
  }
}

class conversationList extends StatelessWidget {
  String id;

  conversationList(this.id);


  String splitMessage (String message)
  {
    var email = message.split(">");
    return email[0];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chats').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final msgs = snapshot.data.documents
                .where((d) => d.documentID == this.id)
                .first['messages'];
            return new ListView(
                padding: EdgeInsets.only(bottom: 80),
                children: [
                  for (int i = 0; i < msgs.length; ++i)
                    Padding(
                      padding:
                      splitMessage(msgs[i]) == staticLogInState.email ? EdgeInsets.only(left: 100, right: 0) : EdgeInsets.only(left: 0, right: 100),
                      child: Card(
                        color:
                        splitMessage(msgs[i]) == staticLogInState.email ? Colors.redAccent : Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        child: ListTile(
                          title: Text(msgs[i],
                              style: Theme.of(context).textTheme.button),
                        ),
                      ),
                    )
                ]);
        }
      },
    );
  }
}
