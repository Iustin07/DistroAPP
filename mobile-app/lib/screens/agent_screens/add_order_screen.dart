import 'package:badges/badges.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';

import '../../screens/cart_screen.dart';
import '../../widgets/orders/order_products_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/cart.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);
  static const routeName = "/order";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(
        title: 'Add order',
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              badgeContent: Text(cart.itemCount.toString()),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OrderProductsList(),
      ),
    );
  }
}
