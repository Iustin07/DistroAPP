import 'package:flutter/material.dart';
import './modify_client.dart';
import '../simple_app_bat.dart';
import '../../model/client.dart';

class ModifyClient extends StatelessWidget {
  const ModifyClient({Key? key}) : super(key: key);
static const routeName="/edit-client";
  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)?.settings.arguments as Client;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title:'Edit Client'),
      body: EditClientForm(client:client),
    );
  }
}