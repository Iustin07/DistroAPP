import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
class ClientLocation extends StatefulWidget {
  static const routeName="/client-location";
  ClientLocation({Key? key,
 this.clientName,
 this.address,
 this.longitude,
 this.latitude,
  }) : super(key: key);
  final String? clientName;
  final double? longitude;
  final double? latitude;
  final String? address;
  @override
  State<ClientLocation> createState() => _ClientLocationState();
}

class _ClientLocationState extends State<ClientLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: Text(widget.clientName as String),),
    body: Container(
      alignment: Alignment.center,
      child:Stack(children: [
          
         Image.asset('assets/images/map.png'),
         Positioned(
           left: 40,
           top: 10,
           child:
           Text(widget.address as String, style: TextStyle(backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
             fontWeight: FontWeight.w600),)),
      ],) 
     
    ),
    );
  }
}