import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/custom_centralizer.dart';

class OrderCheckedCard extends StatefulWidget {
  OrderCheckedCard({Key? key,
  required this.orderId,
  required this.clientName,
  required this.paymentValue,
  required this.totalWeight,
  }) : super(key: key);
  int orderId;
String clientName;
double paymentValue;
double totalWeight;
  @override
  State<OrderCheckedCard> createState() => _OrderCheckedCardState();
}
@override

  

class _OrderCheckedCardState extends State<OrderCheckedCard> {
 bool? option=false;
 CustomCentralizer? centralizer;
 void didChangeDependencies() {
    centralizer=Provider.of<CustomCentralizer>(context,listen: false);
  super.didChangeDependencies();
  }
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   
    return 
               Card(
                  child: CheckboxListTile(
                    title: Text('${widget.clientName}',style:const TextStyle(fontWeight: FontWeight.w600)),
                    tileColor: const  Color.fromARGB(255,214,104,83),
                    activeColor: Colors.amber,
                    subtitle: Row(
                      children: <Widget>[
                        Text('${widget.paymentValue} RON',style:const TextStyle(fontWeight: FontWeight.w500),),
                        const SizedBox(width: 10,),
                        Text('${widget.totalWeight} kg'),
                      ],
                    ),
                    value: option ,
                     onChanged: (value){
                       setState(() {
                      if(option==true && value==false){
                          centralizer!.removeItem(widget.orderId);
                          option=value;
                        } 
                        if(value ==true){
                         centralizer!.addItem(widget.orderId,widget.totalWeight,widget.paymentValue ); 
                          option=value;
                        Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: const Text( 'Added order to centralizer',),
                        duration: const Duration(seconds: 1),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            centralizer!.removeItem(widget.orderId);
                            option=!value! ;
                          },
                        ),
                      ),);
                        }
                   
                       });
                     }),
                );
              
  }
}