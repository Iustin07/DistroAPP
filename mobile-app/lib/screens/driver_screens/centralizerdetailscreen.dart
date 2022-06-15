import 'package:distroapp/model/centralizer.dart';
import 'package:distroapp/screens/driver_screens/centralzier_orders_card.dart';
import 'package:distroapp/widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/centralizers_provider.dart';
class CentralizerDetailsScreen extends StatelessWidget {
  const CentralizerDetailsScreen({Key? key}) : super(key: key);
static const routeName="/centralizer-details-driver";
  @override
  Widget build(BuildContext context) {
    final int id=ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Centralizer $id'),
      body: OrdersList(centralizerId:id),
    );
  }
}
class OrdersList extends StatefulWidget {
  OrdersList({Key? key,required this.centralizerId}) : super(key: key);
  final int centralizerId;
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
 bool _isLoading=false;
 bool __init=true;
 Centralizer? centralizer;
 @override
  void didChangeDependencies() {
    if(__init){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Centralizers>(context).fectchById(widget.centralizerId).then((value){
setState(() {
      centralizer=value;
        _isLoading=false;
});

    
      });
    }
    __init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return   _isLoading? const Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
              child:ConstrainedBox (
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                child: ListView.builder(
                  itemCount: centralizer!.orders.length,
                  itemBuilder: (ctx,index)=>CentralizerOrdersCard(
                    key: ValueKey(centralizer!.orders[index].orderId.toString()),
                    order:centralizer!.orders[index]),
                  ),
              ),
            );
              }
    
    }