import 'package:flutter/material.dart';
import './modify_product_form.dart';
import '../../../model/product.dart';

class ProductModifyScreen extends StatelessWidget{
  const ProductModifyScreen({Key? key}):super(key: key);
  static const routeName='/edit-product';
     @override
   Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as Product;
     return Scaffold(
       appBar: AppBar(title: const Text('Modify product'),
   ),
       body:ModifyProductForm(product:product),
     );;
   }
}
