import 'package:distroapp/model/order.dart';
import '/screens/agent_screens/order_details_products_screen.dart';
import 'package:flutter/material.dart';
import '../../model/order.dart';
import '../../providers/orders_provider.dart';
import 'package:provider/provider.dart';
class OrderCard extends StatelessWidget {
   OrderCard({Key? key,
  required this.order,
  required this.color,
  }) : super(key: key);
  final Order order;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(order.orderId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete,color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin:const  EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                  'Do you want to cancel this order?',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Provider.of<Orders>(context,listen: false).cancelOrder(order.orderId as int).then((_) => Navigator.of(ctx).pop(true) );
                    
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
       //Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(

        color: color,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(OrderDetailsProducts.routeName, arguments: order);
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: 
        
                  Container(
                    width: 50,
                    child: Text('${order.orderId}',softWrap: true,),
                  ),
              
              title: Text(order.client!.clientName.toString()),
              subtitle: Text('Total: ${(order.orderPaymentValue)!.toStringAsFixed(3)} RON'),
              trailing: Text('${(order.totalWeight)!.toStringAsFixed(2)} kg'),
            ),
          ),
        ),
      ),
    );;
  }
}