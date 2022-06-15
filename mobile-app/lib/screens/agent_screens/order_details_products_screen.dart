import 'package:distroapp/screens/agent_screens/agent_order_item.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import '../../model/order.dart';
class OrderDetailsProducts extends StatefulWidget {
  static const routeName="/agent-order-details";
  const OrderDetailsProducts({Key? key,
  }) : super(key: key);

  @override
  State<OrderDetailsProducts> createState() => _OrderDetailsProductsState();
}

class _OrderDetailsProductsState extends State<OrderDetailsProducts> {
  @override
  Widget build(BuildContext context) {
      final Order order=ModalRoute.of(context)?.settings.arguments as Order;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: '${order.orderId} ${order.client!.clientName}',),
      body:SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.85,
            child: 
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Chip(
                            label: Text(
                              '${order.totalWeight!.toStringAsFixed(2)} kg',
                              style: const TextStyle(
                                  //color: Theme.of(context).primaryTextTheme.title.color,
                                  ),
                            ),
                            backgroundColor:Colors.amber,
                          ),
                       Chip(
                            label: Text(
                              '${order.orderPaymentValue!.toStringAsFixed(2)} RON',
                              style: const TextStyle(
                                  //color: Theme.of(context).primaryTextTheme.title.color,
                                  ),
                            ),
                            backgroundColor: Colors.amber,
                          ),
              ],),
              Expanded(child:
                  order.orderProducts!.isEmpty?   const Center(child: Text('something went wrong')):
            ListView.builder(
              itemCount: order.orderProducts!.length,
              itemBuilder: (ctx,index)=>AgentOrderProductItem(orderItem: order.orderProducts![index],orderId: order.orderId,),
              ),
              ),
              ],
            )
            
          
          ),
        ) ,
        );
    
  }
}