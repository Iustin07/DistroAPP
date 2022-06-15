

import 'package:distroapp/widgets/clients/modify_client_screen.dart';

import '../../screens/after_login.dart';
import '../../screens/manage_clients.dart';
import '../../widgets/clients/client_Location.dart';
import 'package:flutter/material.dart';
import '../../model/client.dart';
import 'package:provider/provider.dart';
import '../../providers/clients.dart';
class ClientItem extends StatelessWidget {
  const ClientItem({Key? key, 
  required this.client,
  required this.waiting,
  }) : super(key: key);
  final Client client;
  final bool waiting;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 250, 250, 255),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: InkWell(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              client.registration![0] == 'F'
                  ? Icon(Icons.people)
                  : Icon(Icons.business_outlined),
              Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${client.clientName}',
                         style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${client.phoneNumber}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: waiting? 
                <Widget>[
                    ElevatedButton(onPressed: (){
                      print(client.id);
                      print('Enable was called');
                      Provider.of<Clients>(context,listen: false).enableClient(client);
                      Future.delayed(Duration(seconds: 1),()=>Navigator.of(context).pop()) ;
                    }, child:
                    Text('Enable'),
                    )
                ]:getWidgets(context),
              )
            ]),
      ),
    );
  }
  List<Widget> getWidgets(BuildContext context){
    return
    <Widget>[
                  IconButton(onPressed: () {
                      Provider.of<Clients>(context,listen: false).deleteClient(client.id as int).then((value){
                        if(value==200){
                          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ManageClientsScreen(),
            ),
            ModalRoute.withName('/'));
                        }
                      });

                  }, icon: Icon(Icons.delete)),
                  IconButton(
                      onPressed: () =>
                        Navigator.of(context).pushNamed(ModifyClient.routeName,arguments: client),
                      
                      icon: Icon(Icons.mode_edit)),
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientLocation(
                                clientName: client.clientName,
                                address: client.address,
                                longitude: client.longitude,
                                latitude: client.latitude,
                              ),
                            ),
                          ),
                      icon: Icon(Icons.location_on)),
                ];
  }
}
