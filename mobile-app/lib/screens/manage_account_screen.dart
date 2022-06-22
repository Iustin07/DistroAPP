import 'package:flutter/material.dart';
import '../widgets/auxiliary_widgets/account_form.dart';


class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({Key? key}) : super(key: key);
static const routeName='/account';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(icon:const  Icon(Icons.arrow_back),onPressed: ()=>
          Navigator.of(context).pop()),
        title: const Text('Manage account'),),
      body:  AccountForm(),
  
    );
  }
}