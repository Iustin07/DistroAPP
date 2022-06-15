
import 'package:distroapp/providers/transport_cart.dart';
import 'package:distroapp/screens/storeman_screens/shipping_screen.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import '../../model/transport.dart';
import 'package:provider/provider.dart';
import '../../model/transport_item.dart';
import './body_transport_arrived.dart';
import './body_details_waiting.dart';
import '../../providers/transports.dart';
class TransportDetails extends StatelessWidget {
  TransportDetails({
    Key? key,
  }) : super(key: key);
  static const routeName = "/transport-details";

  @override
  Widget build(BuildContext context) {
    final transport = ModalRoute.of(context)!.settings.arguments as Transport;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: transport.received!
            ?SimpleAppBar(title: 'Details T${transport.idTrasnport}'):
            SimpleAppBar(title: 'Details T${transport.idTrasnport}',
            actions: [
              IconButton(onPressed: (){
 var transportCart =
              Provider.of<TransportCart>(context, listen: false);
          Provider.of<Transports>(context, listen: false).updateTransport(
            transport.idTrasnport as int,
             transportCart.transportItems,
              transportCart.totalValue,
               transport.review)
              
              .then((value) {
            if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Transport was updated',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              
              builder: (BuildContext context) => ShippingScreen(),
            ),
            ModalRoute.withName('/'));
      }     
            
          });
          transportCart.clear();

              }, icon: Icon(Icons.save))
            ],)
            ,
        body: transport.received!
            ? BodyTransportArived(transport: transport)
            : BodyTransportDetailsWaiting(transport: transport));
  }
}

