import 'package:flutter/material.dart';
import '../../model/centralizer.dart';
import './centralzier_card.dart';
import 'package:provider/provider.dart';
import '../../providers/centralizers_provider.dart';
class CentralizersList extends StatefulWidget {
  const CentralizersList({Key? key}) : super(key: key);

  @override
  State<CentralizersList> createState() => _CentralizersListState();
}

class _CentralizersListState extends State<CentralizersList> {
  List<Centralizer>? centralizers;
  bool _isLoading=false;
  bool _init=true;
  @override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Centralizers>(context).fetchCentralizers().then((value) {
        centralizers=List.from(value);
        setState(() {
          _isLoading=false;
        });
      });
    }
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading?const Center(child:CircularProgressIndicator()):Padding(padding:const EdgeInsets.all(10),
      child: SingleChildScrollView(


        child:ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: ListView.builder(
            itemCount: centralizers!.length,
            itemBuilder: (ctx,index)=>CentralizerCard(
              key: ValueKey(centralizers![index].centralizerId.toString()),
              centralizerId: centralizers![index].centralizerId,
             driverName:centralizers![index].driverName,
              date: centralizers![index].date,
               value: centralizers![index].calculatedValuesforValueAndWeight.orderPaymentValue as double, 
               weight:centralizers![index].calculatedValuesforValueAndWeight.totalWeight as double,  )),
        ) ),
      ) ;
  }
}