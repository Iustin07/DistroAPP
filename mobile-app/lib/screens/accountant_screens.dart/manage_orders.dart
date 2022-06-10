import '../../screens/accountant_screens.dart/orders_main_widget.dart';
import 'package:flutter/material.dart';
class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({Key? key}) : super(key: key);
static const routeName="/acc-orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(icon:const  Icon(Icons.arrow_back),onPressed: ()=>
          Navigator.of(context).pop()),
        title: const Text('Manage orders'),),
      body: 
   OrdersMainWidget(context: context,),
      
    );
  }
}

