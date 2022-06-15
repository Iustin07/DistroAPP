import '../../model/centralizer.dart';
import 'package:flutter/material.dart';
import '../../model/order.dart';
import '../../model/orderItem.dart';
class CentralizerOrdersCard extends StatefulWidget {
  CentralizerOrdersCard({Key? key,required this.order}) : super(key: key);
  final Order order;
  @override
  State<CentralizerOrdersCard> createState() => _CentralizerOrdersCardState();
}

class _CentralizerOrdersCardState extends State<CentralizerOrdersCard> {
List<OrderItem>? orderProducts;
@override
void initState() {
  orderProducts=widget.order.orderProducts;
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return 
    Card(
        elevation: 10,
        color: Colors.amber,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: ConstrainedBox(
          constraints:BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Column(
            children: [
              Text(widget.order.client!.clientName as String),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.4),
                child: ExpansionTile(
                  title: Text('See products'),
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width,
                      maxHeight: MediaQuery.of(context).size.height*0.5),
                  child:ListView.builder(
                    itemCount: widget.order.orderProducts!.length,
                    itemBuilder:(cxt,index)=>
                    ListTile(
                    tileColor: Colors.redAccent,
                    title: Text(orderProducts ![index].product!.productName),
                    subtitle: Text(' ${orderProducts![index].productUnits}'),
                    trailing: Text('${orderProducts![index].product!.unitMeasure}'),
                  ),
                ),
            
                  )
          
                ],
                
                ),
              ),
            ],
          ),
        )
      );
  }
}