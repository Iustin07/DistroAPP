import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import './order_card.dart';
import '../../widgets/simple_app_bat.dart';
import '../../providers/orders_provider.dart';
import '../../model/order.dart';
import '../../providers/authentification.dart';
 
 class SeeOrdersScreen extends StatefulWidget {
   const SeeOrdersScreen({Key? key}) : super(key: key);
 static const routeName="/see-orders";

  @override
  State<SeeOrdersScreen> createState() => _SeeOrdersScreenState();
}

class _SeeOrdersScreenState extends State<SeeOrdersScreen> {
   Orders? ordersObject;
  List<Order>? orders;
  bool _loading=false;
  bool _init=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_init){
    setState(() {
      _loading=true;
    });
    int agentId=Provider.of<Authentication>(context,listen: false).userId;
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    Provider.of<Orders>(context).fetchOrderOfAgent(agentId,formatted).then((value) {
       ordersObject =Provider.of<Orders>(context,listen: false);
     setState(() {
        orders=ordersObject!.orders;
       _loading=false;
     });
    });
  
    }
    _init=false;
    super.didChangeDependencies();
  }
   @override
   Widget build(BuildContext context) {
     
     
     return  Scaffold(
       backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title:'See orders'),
      body:SingleChildScrollView(
          child: _loading?const Center(child: CircularProgressIndicator(),)
          :SizedBox(
            height: MediaQuery.of(context).size.height*0.8,
            child: 
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Chip(
                            label: Text(
                              '${ordersObject!.getTotalWeight.toStringAsFixed(2)} kg',
                            ),
                            backgroundColor:Colors.amber,
                          ),
                       Chip(
                            label: Text(
                              '${ordersObject!.getTotalValue.toStringAsFixed(2)} RON',
                            ),
                            backgroundColor: Colors.amber,
                          ),
              ],),
              Expanded(child:
                  orders!.isEmpty?const Center(child: Text('There are no products yet')):
            ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (ctx,index)=>OrderCard(order: orders![index],color: const Color.fromARGB(255,244,208,111),),
              ),
              ),
              ],
            )
            
          
          ),
        ) ,
        );
   }
}