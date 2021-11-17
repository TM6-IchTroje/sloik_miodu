import 'package:firebase_shop_app/core/providers/cart_provider.dart';
import 'package:firebase_shop_app/core/providers/orders_provider.dart';
import 'package:firebase_shop_app/view/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
}

class CartScreen extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<CartScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CartScreen> {
  double _valueOfOrder = 0;

  void _incrementCounter(double value) {

  DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("Wartosci zamowienia");

  setState(() {
  // This call to setState tells the Flutter framework that something has
  // changed in this State, which causes it to rerun the build method below
  // so that the display can reflect the updated values. If we changed
  // _counter without calling setState(), then the build method would not be
  // called again, and so nothing would appear to happen.
  _valueOfOrder = value;
  _testRef.set(_valueOfOrder);
  });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Twój koszyk'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalPriceAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6.color,
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  FlatButton(
                    child: Text('Kup teraz'),
                    onPressed: () {

                      // Listen to OrdersProvider
                      _incrementCounter(cart.totalPriceAmount);

                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                        cart.cartItems.values.toList(),
                        cart.totalPriceAmount,
                      );
                      cart.clearCart();
                    },
                    textColor: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                itemId: cart.cartItems.keys.toList()[i], // CartItem id
                productId: cart.cartItems.values.toList()[i].id,
                price: cart.cartItems.values.toList()[i].price,
                quantity: cart.cartItems.values.toList()[i].quantity,
                title: cart.cartItems.values.toList()[i].title,
                imageUrl: cart.cartItems.values.toList()[i].imageUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
