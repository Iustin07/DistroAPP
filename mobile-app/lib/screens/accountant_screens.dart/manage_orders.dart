import 'package:flutter/material.dart';
import '../../widgets/simple_app_bat.dart';
import '../../screens/accountant_screens.dart/orders_main_widget.dart';
class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({Key? key}) : super(key: key);
static const routeName="/acc-orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Manage orders'),
      body: OrdersMainWidget(context: context,),
      
    );
  }
}

