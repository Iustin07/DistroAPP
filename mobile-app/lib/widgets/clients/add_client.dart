import 'package:flutter/material.dart';
import './add_client_form.dart';
import '../simple_app_bat.dart';

class AddClientScreen extends StatelessWidget {
  const AddClientScreen({Key? key}) : super(key: key);
static const routeName="/add-client";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
      appBar:SimpleAppBar(title: 'Add Client',),
      body: const AddClientForm(),
    );
  }
}


