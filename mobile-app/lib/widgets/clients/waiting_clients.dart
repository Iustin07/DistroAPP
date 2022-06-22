import 'package:flutter/material.dart';
import './clients_list.dart';

class WaitingClientsScreen extends StatefulWidget {
 const WaitingClientsScreen({Key? key}) : super(key: key);
static const routeName="/waiting-clients";
  @override
  State<WaitingClientsScreen> createState() => _WaitingClientsScreenState();
}

class _WaitingClientsScreenState extends State<WaitingClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(icon:const  Icon(Icons.arrow_back),onPressed: ()=>
          Navigator.of(context).pop()),
        title:const Text('Waiting clients')),
      body: const ClientsList(enabled:false),
    );
  }
}