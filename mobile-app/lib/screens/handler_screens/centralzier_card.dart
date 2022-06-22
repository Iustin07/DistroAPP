import 'package:distroapp/providers/authentification.dart';
import 'package:provider/provider.dart';
import './centralizer_details.screen.dart';
import 'package:flutter/material.dart';
class CentralizerCard extends StatelessWidget {
   CentralizerCard({Key? key,
  required this.centralizerId,
  required this.driverName,
  required this.date,
  required this.value,
  required this.weight,
  
  }) : super(key: key);
  String driverName;
  int centralizerId;
  String date;
  double weight;
  double value;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 224, 224, 224),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Row(children: <Widget>[
        Container(
          width: 50,
          margin: const EdgeInsets.only(left: 3),
          child: Text(
            '${centralizerId}',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(left: 8, right: 3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        maxLines: 1,
                       driverName,
                        style:const  TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Value: ${value.toStringAsFixed(0)} Ron', softWrap: true,),
                        Text('Weight: ${weight.toStringAsFixed(0)} kg', softWrap: true,),
                      
                      ],
                    )
                  ]),
            )),
        Row(
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(CentralizerDetails.routeName, arguments: [centralizerId,driverName]);
            },
             child:Provider.of<Authentication>(context).getRole=='handler'?const  Text('Assign'): const Text("Details")
             ),      
      
          ],
        )
      ]),
    );;
  }
}
