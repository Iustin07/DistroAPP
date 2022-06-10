import 'package:distroapp/widgets/auxiliary_widgets/manage_products_widgets/modify_product_form.dart';

import '../../../model/product.dart';
import 'package:flutter/material.dart';
class ProductModifyScreen extends StatelessWidget{
  static const routeName='/edit-product';
     @override
   Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
     return Scaffold(
       appBar: AppBar(title: Text('Modify product'),
   ),
       body:ModifyProductForm(product:product),
     );;
   }
}
