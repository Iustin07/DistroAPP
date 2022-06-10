import './add_client_form.dart';
import 'package:flutter/material.dart';
class AddClientScreen extends StatelessWidget {
  const AddClientScreen({Key? key}) : super(key: key);
static const routeName="/add-client";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: Text('Add Client'),
      ),
      body: AddClientForm(),
    );
  }
}


