import '../widgets/clients/waiting_clients.dart';

import '../widgets/clients/add_client.dart';
import 'package:flutter/material.dart';
import '../widgets/clients/clients_list.dart';
class ManageClientsScreen extends StatelessWidget {
  const ManageClientsScreen({Key? key}) : super(key: key);
static const routeName='/clients';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(icon:const  Icon(Icons.arrow_back),onPressed: ()=>
          Navigator.of(context).pop()),
        title: const Text('Manage clients'),
        actions: <Widget>[
          IconButton(onPressed: ()=>Navigator.of(context).pushNamed(WaitingClientsScreen.routeName), icon: Image.asset('assets/images/waiting.png',color:  Colors.white)),
          IconButton(onPressed: ()=>Navigator.of(context).pushNamed(AddClientScreen.routeName)
          , icon: Icon(Icons.add))
        ],
        ),
      body:  Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClientsList(enabled: true,),
  ),
      );

  }
}