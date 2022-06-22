import 'package:distroapp/widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/summar.dart';
import '../../providers/centralizers_provider.dart';
class CentralizerDetails extends StatelessWidget {
  CentralizerDetails({Key? key
  }) : super(key: key);
  static const routeName="/centralizer-details";
int? centralizerId;
String? driverName;
  @override
  Widget build(BuildContext context) {
    List<dynamic> args=ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    centralizerId=args[0] as int;
    driverName=args[1] as String;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:  SimpleAppBar(title: 'Centralizer: $driverName',),
      body:DetailsSummary(centralizerId: centralizerId,),
      )
      ;
  }
}

class DetailsSummary extends StatefulWidget {
  DetailsSummary({Key? key,this.centralizerId}) : super(key: key);
  int? centralizerId;
  @override
  State<DetailsSummary> createState() => _DetailsSummaryState();
}

class _DetailsSummaryState extends State<DetailsSummary> {
List<Summar>? summar;
bool _isLoading=false;
bool _init=true;
@override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Centralizers>(context).readSummar(widget.centralizerId as int).then((value){
        setState(() {
                summar=List.from(value);
        _isLoading=false; 
        });
 
      });
    }
    _init=false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?const Center(child: CircularProgressIndicator(),):Padding(padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight:MediaQuery.of(context).size.height ),
          child: ListView.builder(
            itemCount: summar!.length,
            itemBuilder: (ctx,index)=>Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(236, 240, 241, 1),
                borderRadius: BorderRadius.circular(10),
              )
              ,
              margin: const EdgeInsets.only(top: 5,bottom: 5,left: 15,right: 15),
              height: 60,
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${index+1}'),
                  Text('${summar![index].productName}'),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                       Row(
                         children: [
                           
                           Text('${summar![index].divider.palletQuantity} pal '),
                           const Icon(Icons.cabin_outlined,size: 15,),
                         ],
                       ),
                  Row(
                    children: [
                     
                      Text('${summar![index].divider.boxQuantiy} boxes'),
                       Image.asset('assets/images/box-512.png',height: 18,),
                    ],
                  ),
                  Row(
                    children: [
                     
                      Text('${summar![index].divider.bucQuantity} buc'),
                       const Icon(Icons.ballot_outlined,size: 15,),
                    ],
                  ),
                    ],
                  )
                 
                ],),
            )),
        ),
          
     ),
      ) ;

}

}