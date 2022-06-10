import '../widgets/auxiliary_widgets/manage_products_widgets/add_product.dart';
import 'package:flutter/material.dart';
import '../widgets/auxiliary_widgets/manage_products_widgets/products_list_widget.dart';

class ManageProductsScreen extends StatelessWidget {
  const ManageProductsScreen({Key? key}) : super(key: key);
  static const routeName = '/products';
  final option = false;

  @override
  Widget build(BuildContext context) {
    print('build manage calaled');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Manage products'),
        actions: <Widget>[
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddProductScreen.routeName),
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blue[800],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductsList(),
        ),
      ),
    );
  }
}
