import 'dart:async';
import 'package:distroapp/providers/authentification.dart';
import 'package:distroapp/screens/manage_clients.dart';
import 'package:provider/provider.dart';
import '../../providers/clients.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class AddClientForm extends StatefulWidget {
  AddClientForm({Key? key}) : super(key: key);

  @override
  State<AddClientForm> createState() => _AddClientFormState();
}

class _AddClientFormState extends State<AddClientForm> {
  String? latitude='',longitude='';
  final _clientForm=GlobalKey<FormState>();
  final _clientNameFocusNode=FocusNode();
final _phoneNumberFocusNode=FocusNode();
final _cifFocusNode=FocusNode();
final _addressFocusNode=FocusNode();
final _registrationNumberFocusNode=FocusNode();
final _longitudeFocusNode=FocusNode();
final _latitudeFocusNode=FocusNode();
Map<String,dynamic> client={
      'clientName':'',
      'address':'',
      'clientPhoneNumber':'',
      'cif':'',
      'commerceRegistrationNumber':'',
      'longitude':0.0,
      'latitude':0.0,

    };
  bool _loading=false;
  Position? postion;
bool _isLocationRequested=false;
  void _saveForm()async{
    //form validations
    _clientForm.currentState!.save();
  setState(() {
    _loading=true;
  });
      try {
        await Provider.of<Clients>(context, listen: false)
            .addClient(client);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occurred!'),
                content: const Text('Something went wrong.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
      setState(() {
        _loading=false;
      });
      String role=Provider.of<Authentication>(context,listen: false).getRole;
      print('role is $role');
      if(role=='agent'){
        Navigator.of(context).pop();
      }else{
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => ManageClientsScreen(),
      ),
      ModalRoute.withName('/'));};
      //remove until home and push /manage clients again
    
  }
  

  @override
  void initState() {
    
    super.initState();
    
  }
  @override
  void dispose() {
    _clientNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _cifFocusNode.dispose();
    _addressFocusNode.dispose();
    _registrationNumberFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _loading?Center(child: CircularProgressIndicator(),):Container(
              padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              margin: EdgeInsets.only(left:20,right: 20,top: 20),
              decoration: BoxDecoration(
               //color: Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
                  
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height),
                      child: Column(
                        children: [
                          Image.asset('assets/images/client.png'),
                       Expanded(
                        
                                

                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _clientForm,
                                        child: Column(
                                          children: <Widget>[
                                            CustomTextField('Client name',client["clientName"],2,TextInputType.text,_clientNameFocusNode,(value){
                                              client["clientName"]=value;
                                            }),
                                            CustomTextField('Address',client["address"],3,TextInputType.text,_addressFocusNode,(value){
                                              client["address"]=value;
                                            }),
                                            CustomTextField('Phone Number',client["clientPhoneNumber"],1,TextInputType.text,_phoneNumberFocusNode,(value){
                                              client["clientPhoneNumber"]=value;
                                            }),
                                            CustomTextField('CIF',client["cif"],1,TextInputType.text,_cifFocusNode,(value){
                                              client["cif"]=value;
                                            }),
                                             CustomTextField('Commerce registration code',client["commerceRegistrationNumber"],1,TextInputType.text,_registrationNumberFocusNode,(value){
                                               client["commerceRegistrationNumber"]=value;
                                             }),
                                            _isLocationRequested?CircularProgressIndicator() :Column(children: <Widget>[
                                               CustomTextField('Longitude',longitude,1,TextInputType.number,_longitudeFocusNode,(value){
                                              client["longitude"]=double.parse(value);
                                            }),
                                             CustomTextField('Latitude',latitude,1,TextInputType.number,_latitudeFocusNode,(value){
                                               client["latitude"]=double.parse(value);
                                             }),
                                             ],),
                                            
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: <Widget>[

                                                ElevatedButton.icon(
                                                  icon: Icon(Icons.location_on_outlined),
                                                  label: Text('Get my location'),onPressed: (){
                                                    setState(() {
                                                      _isLocationRequested=true;
                                                    });
                                                    _determinePosition().then((value){
                                                      setState(() {

                                                        postion=value;
                                                        latitude=postion!.latitude.toString();
                                                        longitude=postion!.longitude.toString();
                                                        print(postion!.latitude.toString());
                                                        _isLocationRequested=false;
                                                      });
                                                    } );

                                                  },),
                                             ],),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                 ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Cancel')),
                                                ElevatedButton(onPressed: ()=>_saveForm(), child: Text('Add')),
                                               
                                              ],
                                            ),
                                            
                                          ],
                                        ),
                                      
                                    ),
                                  ),
                              
                              ),
                       
                        
                        ],
                      ),
                    ),
                  
              
            
            
          );
  }

 Widget CustomTextField(String title,dynamic initialValue,int lines,TextInputType inputType,FocusNode node,Function saveHandler) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
                      initialValue: initialValue.toString(),
                      maxLines: lines,
                      decoration:  InputDecoration(
                        fillColor:Color.fromARGB(238, 255, 255, 255),
                        filled: true,
                        labelStyle: TextStyle(color:node.hasFocus?Color.fromRGBO(72, 40, 74, 1): Colors.black,
                        fontWeight: node.hasFocus?FontWeight.bold:FontWeight.normal
                        ),
                        labelText: title,
                        enabledBorder:const  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color:Color.fromRGBO(201, 100, 128, 1.0), width: 3.0)),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: inputType,
                      focusNode: node,
                      onTap: () {
                        setState(() {
                  FocusScope.of(context).requestFocus(node);        
                        });
                  
                },
                onFieldSubmitted: (_){
                    setState(() {
                      FocusScope.of(context).unfocus();
                    });
                },
                      onSaved: (value)=>saveHandler(value),
                    ),
    );
  }
  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
print('fuhction called');
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  //desiredAccuraccy:Loatiob.high
  //return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best,timeLimit: Duration(minutes: 1));
return Position(longitude: 47.08796,
 latitude: 26.874545,
  timestamp: DateTime.now(),
   accuracy: 50,
    altitude: 300,
     heading: 34.8900,
      speed: 0.5,
       speedAccuracy: 0.7);
}
}
