import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/authentification.dart';
import '../../screens/accountant_screens.dart/add_transport.dart';
import '../../screens/storeman_screens/transports_main_widget.dart';
import '../../screens/storeman_screens/waiting_transports_screen.dart';
import '../../widgets/simple_app_bat.dart';
class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  static const routeName = '/shipping';

  @override
  Widget build(BuildContext context) {
    String role=Provider.of<Authentication>(context,listen: false).getRole;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Shpping',
      actions: <Widget>[
                Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
                onPressed: () =>Navigator.of(context).pushNamed(WaitingTransportsScreen.routeName),
                icon: Image.asset('assets/images/shipping_icon.png',
                    color: Colors.white)),
          ),
          role=='accountant'? IconButton(onPressed: ()=>Navigator.of(context).pushNamed(AddTransportScreen.routeName),
           icon: const Icon(Icons.add)): Container()
      ],),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: TransportsMainWidget(isWainting:false),
      ),
    );
  }
}