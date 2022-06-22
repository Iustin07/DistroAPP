import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/transport.dart';
import '../../providers/transports.dart';
import './detailing_transport.dart';
class TransportsMainWidget extends StatefulWidget {
  TransportsMainWidget({Key? key,required this.isWainting}) : super(key: key);
  bool isWainting;
  @override
  State<TransportsMainWidget> createState() => _TransportsMainScreenState();
}

class _TransportsMainScreenState extends State<TransportsMainWidget> {
   List<Transport>? _transports;
  bool _loading=false;
  @override
  void didChangeDependencies() {
    setState(() {
      _loading=true;
    });
    if(!widget.isWainting){
    Provider.of<Transports>(context,listen: false).fetchTransports(true).then((value) {
      setState(() {
        _transports=List.from(value);
        _loading=false;
      });
    });
    }else{
      Provider.of<Transports>(context,listen: false).fetchTransports(false).then((value) {
      setState(() {
        _transports=List.from(value);
        _loading=false;
      });
    });
    }
    super.didChangeDependencies();
    
  }
  @override
  Widget build(BuildContext context) {
    return _loading?const Center(child: CircularProgressIndicator(),):
    ListView.builder(
      itemCount: _transports!.length,
      itemBuilder: (ctx,index)=>Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTileCard(transport: _transports![index],isWaiting:widget.isWainting)
      )
      
      
    );
  }
}
class ListTileCard extends StatelessWidget {
   ListTileCard({Key? key,
  this.transport,
  this.isWaiting,
  }) : super(key: key);
Transport? transport;
bool? isWaiting;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.black),
          ),
          key: ValueKey(transport!.idTrasnport.toString()),
          textColor: Colors.white,
          tileColor: Colors.blueAccent.shade400,
          leading:const Icon(Icons.local_shipping_rounded,size: 35,),
          title: Text(transport!.producer as String),
          subtitle:isWaiting! ?Column(children: <Widget>[
            Text(transport!.dateArrive as String),
            Text('Retour: ${transport!.retour.toString()}'),
            Text('Driver: ${transport!.driverName}'),
            Text(transport!.driverPhoneNumber.toString()),
          ],) :Text(transport!.dateArrive as String),
          trailing:isWaiting!? Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                  ),
                  onPressed: ()=>Navigator.of(context).pushNamed(TransportDetails.routeName,arguments: transport!),
                  child: const Text('Receive'),
                ),
              ],
            )
          :Text('Retour: ${transport!.retour.toString()}'),
          onTap: isWaiting!?()=>{} :()=>Navigator.of(context).pushNamed(TransportDetails.routeName,arguments: transport!),
                          );
        
  }
}

