import 'package:distroapp/providers/authentification.dart';
import 'package:distroapp/screens/accountant_screens.dart/add_transport.dart';
import 'package:distroapp/screens/storeman_screens/transports_main_widget.dart';
import 'package:distroapp/screens/storeman_screens/waiting_transports_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  static const routeName = '/shipping';

  @override
  Widget build(BuildContext context) {
    String role=Provider.of<Authentication>(context,listen: false).getRole;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Shipping'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
                onPressed: () =>Navigator.of(context).pushNamed(WaitingTransportsScreen.routeName),
                icon: Image.asset('assets/images/shipping_icon.png',
                    color: Colors.white)),
          ),
          role=='accountaut'? IconButton(onPressed: ()=>Navigator.of(context).pushNamed(AddTransportScreen.routeName),
           icon: Icon(Icons.add)): Container()
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: TransportsMainWidget(isWainting:false),
      ),
    );
  }
}