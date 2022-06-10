import 'package:flutter/material.dart';
import '../../model/orderItem.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';
class AgentOrderProductItem extends StatelessWidget {
   AgentOrderProductItem({Key? key,
  required this.orderItem,
  required this.orderId,
  }) : super(key: key);
  OrderItem orderItem;
  int? orderId;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(orderItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child:  const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                  'Do you want to delete this order item?',
                ),
                actions: <Widget>[
                  FlatButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  FlatButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
      Provider.of<Orders>(context,listen: false).removeOrderItem(orderItem.id!, orderId as int);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding:const  EdgeInsets.all(8),
          child: ListTile(
            title: Text(orderItem.product!.productName),
            subtitle: Text('Total: ${(orderItem.product!.priceChoice * orderItem.productUnits).toStringAsFixed(2)} RON'),
            trailing: Text('${orderItem.productUnits} ${orderItem.product!.unitMeasure}'),
          ),
        ),
      ),
    );
  }
}