import 'package:distroapp/model/custom_centralizer.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';
import '../../providers/centralizers_provider.dart';
import './centralizers_main_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';

class ManageCentralizerScreen extends StatefulWidget {
  const ManageCentralizerScreen({Key? key}) : super(key: key);
  static const routeName = "/manage-centralizer";

  @override
  State<ManageCentralizerScreen> createState() =>
      _ManageCentralizerScreenState();
}

class _ManageCentralizerScreenState extends State<ManageCentralizerScreen> {
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:SimpleAppBar(
        title: 'Manage Centralizers',
      ),
      body:  _isLoading?Center(child: CircularProgressIndicator(),):CentralizerMainWidget(
        context: context,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
    
          var centralizer =
              Provider.of<CustomCentralizer>(context, listen: false);
          Provider.of<Centralizers>(context, listen: false)
              .addCentralizer(centralizer.orders, centralizer.driverId)
              .then((value) {
            if (value == 200) {
              // final ordersList = centralizer.orders;
              // final orderProvider = Provider.of<Orders>(context, listen: false);
              // ordersList.forEach((element) {
              //   orderProvider.removeOrderFromList(element.orderId);
              // });
                  ScaffoldMessenger.of(context).showSnackBar(
                
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Centralizer was created',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
            }
          });
          centralizer.clear();
        },
        label: const Text('Create'),
        icon: const Icon(Icons.save_alt),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
