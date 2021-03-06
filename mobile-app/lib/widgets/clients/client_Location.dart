import 'package:distroapp/providers/authentification.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
class ClientLocation extends StatelessWidget {
const  ClientLocation({Key? key,
 this.clientName,
 this.address,
 this.longitude,
 this.latitude,
  }) : super(key: key);
 static const routeName="/client-location";
   final String? clientName;
  final double? longitude;
  final double? latitude;
  final String? address;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(clientName as String),),
    // body: Container(
    //   alignment: Alignment.center,
    //   child:Stack(children: [
          
    //      Image.asset('assets/images/map.png'),
    //      Positioned(
    //        left: 40,
    //        top: 10,
    //        child:
    //        Text(address as String, style:const TextStyle(backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
    //          fontWeight: FontWeight.w600),)),
    //   ],) 
     
    // ),
    body:ClientMapRender(address: address,clientName: clientName,latitude: latitude,longitude: longitude,),
    );
  }
}





class ClientMapRender extends StatefulWidget {
  ClientMapRender({Key? key,
  required this.clientName,
 required this.address,
 required this.longitude,
 required this.latitude,
  
  }) : super(key: key);
  final String? clientName;
  final double? longitude;
  final double? latitude;
  final String? address;
  @override
  State<ClientMapRender> createState() => _ClientMapRenderState();
}

class _ClientMapRenderState extends State<ClientMapRender> {
    Position? position;
bool _init=true;
bool _laoding=false;
String userRole='';
@override
void didChangeDependencies() {
if(_init){
  setState(() {
    _laoding=true;
     userRole=Provider.of<Authentication>(context).getRole;
  });
  if(userRole=='driver'){
    
   _determinePosition().then((value) {
    setState(() {
      position=value;
      _laoding=false;
    });
  });
  print('driver is on');
  }else{
    setState(() {
      _laoding=false;
    });
  }
}

 _init=false;
  super.didChangeDependencies();
  
}
  final Map<String, Marker> _markers = {};
  
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      
        final marker = Marker(
          markerId: MarkerId(widget.clientName as String ),
          position: LatLng(widget.latitude as double,widget.longitude as double),
          infoWindow: InfoWindow(
            title: widget.clientName,
            snippet: widget.address,
          ),
        );
      _markers[widget.clientName as String] = marker;
    });
  }
  @override
  Widget build(BuildContext context) {
    return _laoding?const Center(child: CircularProgressIndicator(),): GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:  CameraPosition(
            target: userRole=='driver'? LatLng(position!.latitude,position!.longitude):LatLng(widget.latitude as double ,widget.longitude as double),
            zoom: 8,
          ),
          markers: _markers.values.toSet(),
        );
  }
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {

    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
      return Position(
        longitude:26.874545 ,
        latitude: 47.08796,
        timestamp: DateTime.now(),
        accuracy: 50,
        altitude: 300,
        heading: 34.8900,
        speed: 0.5,
        speedAccuracy: 0.7);
  
  //return await Geolocator.getCurrentPosition();
}
}
