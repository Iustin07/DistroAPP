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
        color: Colors.blue.shade400,
        elevation: 10,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: ConstrainedBox(
          constraints:BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Column(
            children: [
              Text(widget.order.client!.clientName as String,style: TextStyle(fontSize: 20,color: Colors.white)),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.4),
                child: ExpansionTile(
                  title: Text('See products',style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  SingleChildScrollView(
                    
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height*0.5),
                    child:ListView.builder(
                      itemCount: widget.order.orderProducts!.length,
                      itemBuilder:(cxt,index)=>
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(color: Colors.black),
                            ),
                        tileColor: Color.fromRGBO(211,211,211,1),
                        title: Text(orderProducts ![index].product!.productName),
                        subtitle: Text(' ${orderProducts![index].productUnits}'),
                        trailing: Text('${orderProducts![index].product!.unitMeasure}'),
                    ),
                      ),
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