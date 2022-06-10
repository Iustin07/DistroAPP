import '../widgets/auxiliary_widgets/account_form.dart';
import 'package:flutter/material.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({Key? key}) : super(key: key);
static const routeName='/account';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const  Icon(Icons.arrow_back),onPressed: ()=>
          Navigator.of(context).pop()),
        title: const Text('Manage account'),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
    color: Theme.of(context).primaryColor,
  ),
  child: AccountForm(),
      ),
    );
  }
}