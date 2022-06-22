import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './modify_client_screen.dart';
import '../../screens/manage_clients.dart';
import '../../widgets/clients/client_Location.dart';
import '../../model/client.dart';
import '../../providers/clients.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({
    Key? key,
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
                  ? const Icon(Icons.people)
                  : const Icon(Icons.business_outlined),
              Container(
                  margin:const EdgeInsets.only(left: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${client.clientName}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${client.phoneNumber}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: waiting
                    ? <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<Clients>(context, listen: false)
                                .enableClient(client);
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ManageClientsScreen(),
                                  ),
                                  ModalRoute.withName('/'));
                            });
                          },
                          child: const Text('Enable'),
                        )
                      ]
                    : getWidgets(context),
              )
            ]),
      ),
    );
  }

  List<Widget> getWidgets(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            Provider.of<Clients>(context, listen: false)
                .deleteClient(client.id as int)
                .then((value) {
              if (value == 200) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ManageClientsScreen(),
                    ),
                    ModalRoute.withName('/'));
              }
            });
          },
          icon: const Icon(Icons.delete)),
      IconButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(ModifyClient.routeName, arguments: client),
          icon: const Icon(Icons.mode_edit)),
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
          icon: const Icon(Icons.location_on)),
    ];
  }
}
