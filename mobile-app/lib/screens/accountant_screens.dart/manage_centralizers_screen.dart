import 'package:distroapp/screens/accountant_screens.dart/generate_centralizers_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/custom_centralizer.dart';
import '../../widgets/simple_app_bat.dart';
import '../../providers/centralizers_provider.dart';
import './centralizers_main_widget.dart';
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
        actions: [
          IconButton(onPressed: ()=>Navigator.of(context).pushNamed(GenerateCentralizersScreen.routeName), icon:const Icon(Icons.library_books_sharp))
        ],
      ),
      body:  _isLoading?const Center(child: CircularProgressIndicator(),):CentralizerMainWidget(
        context: context,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
    
          var centralizer =Provider.of<CustomCentralizer>(context, listen: false);
          if(centralizer.driverId==-1 || centralizer.orders.isEmpty){
              showDialog(context: context
              , builder: (context)=>
              AlertDialog(
                content: const Text('Can\'t create centralizer without orders or without driver'),
actions: <Widget>[
  TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
],
              )
              );
          }else{
          Provider.of<Centralizers>(context, listen: false)
              .addCentralizer(centralizer.orders, centralizer.driverId)
              .then((value) {
            if (value == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Centralizer was created',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1)).then((_){
              final ordersList = centralizer.orders;
              final orderProvider = Provider.of<Orders>(context, listen: false);
              ordersList.forEach((element) {
                orderProvider.removeOrderFromList(element.orderId);
              });
                  });
                              
            }
          });
          centralizer.clear();
        }},
        label: const Text('Create'),
        icon: const Icon(Icons.save_alt),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
