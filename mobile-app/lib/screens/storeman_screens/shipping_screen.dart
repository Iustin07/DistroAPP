import 'package:flutter/material.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  static const routeName = '/shipping';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Shipping'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/images/shipping_icon.png',
                    color: Colors.white)),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}