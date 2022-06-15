import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/client.dart';
import '../../providers/clients.dart';
import './client_item.dart';
class ClientsList extends StatefulWidget {
  const ClientsList({Key? key,
  required this.enabled,
  }) : super(key: key);
  final bool enabled;
  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  List<Client> _clients=[];
  bool _isLoading=false;
 bool _init=true; 
  @override
  void initState() {
 
    super.initState();
  }
  @override
  void didChangeDependencies() {
      if(_init){
        setState(() {
      _isLoading=true;
    });
     Provider.of<Clients>(context).fetchAndSetClients(widget.enabled).then((value) {
       setState(() {
          _clients=Provider.of<Clients>(context,listen: false).clients;
          _isLoading=false;
       });
     });
    
      }
      _init=false;
    super.didChangeDependencies();
  }
  @override
  void deactivate() {
    super.deactivate();
  }
  @override
  void dispose() {
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading? const Center(child: CircularProgressIndicator(),):SingleChildScrollView(
         child: SizedBox(
          height: MediaQuery.of(context).size.height*0.8,
         child:_clients.isEmpty?const Center(child: Text('there are no clients loaded yet'),) :ListView.builder(
       itemCount: _clients.length,
       itemBuilder: (ctx,index)=>widget.enabled?ClientItem(key:ValueKey(_clients[index].id.toString()),client:_clients[index],waiting:false):
       ClientItem(key:ValueKey(_clients[index].id.toString()),client:_clients[index],waiting:true),
        ),
        )
        ,
    );
    }
}