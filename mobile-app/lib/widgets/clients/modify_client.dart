import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../screens/manage_clients.dart';
import '../../utils/validation.dart';
import '../../model/client.dart';
import '../../providers/clients.dart';

class EditClientForm extends StatefulWidget {
  EditClientForm({Key? key, required this.client}) : super(key: key);
  Client client;
  @override
  State<EditClientForm> createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientForm> {
  String? latitude = '', longitude = '';
  final _clientForm = GlobalKey<FormState>();
  final _clientNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _cifFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _registrationNumberFocusNode = FocusNode();
  final _longitudeFocusNode = FocusNode();
  final _latitudeFocusNode = FocusNode();
  Map<String, dynamic> _client = {
    'id': 0,
    'clientName': '',
    'address': '',
    'clientPhoneNumber': '',
    'cif': '',
    'commerceRegistrationNumber': '',
    'longitude': 0.0,
    'latitude': 0.0,
  };
  bool _loading = false;
  Position? postion;
  bool _isLocationRequested = false;
  void _saveForm() async {
    if(!_clientForm.currentState!.validate()){
      return ;
    }
    _clientForm.currentState!.save();
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Clients>(context, listen: false)
          .updateClient(widget.client.id as int, _client);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ManageClientsScreen(),
          ),
          ModalRoute.withName('/'));
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  Image.asset('assets/images/client.png'),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _clientForm,
                        child: Column(
                          children: <Widget>[
                            CustomTextField('Client name',widget.client.clientName,2,TextInputType.text,_clientNameFocusNode,
                                (value) =>Validator.validateGeneral(value), 
                                (value) {_client["clientName"] = value;}),
                            CustomTextField( 'Address',widget.client.address,3,TextInputType.text, _addressFocusNode,
                                (value) =>Validator.validateGeneral(value), 
                                (value) { _client["address"] = value;}),
                            CustomTextField('Phone Number',widget.client.phoneNumber, 1,TextInputType.text, _phoneNumberFocusNode,
                                (value) => Validator.validatePhoneNumber(value),
                                (value) { _client["clientPhoneNumber"] = value;}),
                            CustomTextField('CIF', widget.client.cif,1,TextInputType.text, _cifFocusNode,
                                (value) => Validator.validateCif(value),
                                (value) { _client["cif"] = value;}),
                            CustomTextField('Commerce registration code', widget.client.registration,1,TextInputType.text,_registrationNumberFocusNode,
                                (value) => Validator.validateCRN(value),
                                (value) {_client["commerceRegistrationNumber"] = value;}),
                            _isLocationRequested
                                ? const CircularProgressIndicator()
                                : Column(
                                    children: <Widget>[
                                      CustomTextField('Longitude',widget.client.longitude,1,TextInputType.number, _longitudeFocusNode,
                                          (value) =>Validator.validateDouble(value),
                                          (value) {_client["longitude"] =double.parse(value);}),
                                      CustomTextField('Latitude',widget.client.latitude,1,TextInputType.number, _latitudeFocusNode,
                                          (value) =>Validator.validateDouble(value),
                                          (value) {_client["latitude"] =double.parse(value);}),
                                    ],
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton.icon(
                                  icon:const Icon(Icons.location_on_outlined),
                                  label: const Text('Get  location'),
                                  onPressed: () {
                                    setState(() {
                                      _isLocationRequested = true;
                                    });
                                    _determinePosition().then((value) {
                                      setState(() {
                                        postion = value;
                                        latitude = postion!.latitude.toString();
                                        longitude =
                                            postion!.longitude.toString();
                                        _isLocationRequested = false;
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () => _saveForm(),
                                    child: const Text('Edit')),
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

  Widget CustomTextField(
      String title,
      dynamic initialValue,
      int lines,
      TextInputType inputType,
      FocusNode node,
      Function validateHandler,
      Function saveHandler) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        initialValue: initialValue.toString(),
        maxLines: lines,
        decoration: InputDecoration(
          fillColor:const  Color.fromARGB(238, 255, 255, 255),
          filled: true,
          labelStyle: TextStyle(
              color:
                  node.hasFocus ?const Color.fromRGBO(72, 40, 74, 1) : Colors.black,
              fontWeight: node.hasFocus ? FontWeight.bold : FontWeight.normal),
          labelText: title,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black45, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                  color: Color.fromRGBO(201, 100, 128, 1.0), width: 3.0)),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: inputType,
        focusNode: node,
        onTap: () {
          setState(() {
            FocusScope.of(context).requestFocus(node);
          });
        },
        onFieldSubmitted: (_) {
          setState(() {
            FocusScope.of(context).unfocus();
          });
        },
        validator: (value) => validateHandler(value),
        onSaved: (value) => saveHandler(value),
      ),
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
    //return  Geolocator.getCurrentPosition();
    return Position(
        longitude: 47.08796,
        latitude: 26.874545,
        timestamp: DateTime.now(),
        accuracy: 50,
        altitude: 300,
        heading: 34.8900,
        speed: 0.5,
        speedAccuracy: 0.7);
  }
}
