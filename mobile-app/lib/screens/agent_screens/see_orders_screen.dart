 import 'package:distroapp/providers/authentification.dart';
import 'package:intl/intl.dart';
import './order_card.dart';
import '../../widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
 import 'package:provider/provider.dart';
 import '../../providers/orders_provider.dart';
 import '../../model/order.dart';
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
     orders=ordersObject!.orders;
     setState(() {
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
          child: _loading?Center(child: CircularProgressIndicator(),)
          :Container(
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
                              style: TextStyle(
                                  //color: Theme.of(context).primaryTextTheme.title.color,
                                  ),
                            ),
                            backgroundColor:Colors.amber,
                          ),
                       Chip(
                            label: Text(
                              '${ordersObject!.getTotalValue.toStringAsFixed(2)} RON',
                              style: TextStyle(
                                  //color: Theme.of(context).primaryTextTheme.title.color,
                                  ),
                            ),
                            backgroundColor: Colors.amber,
                          ),
              ],),
              Expanded(child:
                  orders!.isEmpty?Container(child: Text('There are no products yet'),):
            ListView.builder(
              itemCount: orders!.length,
              itemBuilder: (ctx,index)=>OrderCard(order: orders![index],color: Color.fromARGB(255,244,208,111),),
              ),
              ),
              ],
            )
            
          
          ),
        ) ,
        );
   }
}