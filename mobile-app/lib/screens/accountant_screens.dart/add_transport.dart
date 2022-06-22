import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/transports.dart';
import '../../utils/validation.dart';
import '../../widgets/simple_app_bat.dart';
class AddTransportScreen extends StatelessWidget {
  const AddTransportScreen({Key? key}) : super(key: key);
static const routeName="/add-transport";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Add transport',),
      body: AddTransportBody(),
    );
  }
}



class AddTransportBody extends StatefulWidget {
  AddTransportBody({Key? key}) : super(key: key);
static const routeName="/add-transport";
  @override
  State<AddTransportBody> createState() => _AddTransportBodyState();
}

class _AddTransportBodyState extends State<AddTransportBody> {
    bool _loading=false;
    DateTime? _selectedDate;
    bool _isChecked=false;
  final _transportForm=GlobalKey<FormState>();
Map<String,dynamic> _transport={
      'producer':'',
      'dateArrive':'',
      'driverName':'',
      'driverPhoneNumber':'',
      'truckRegistrationNumber':'',
      'retour':false
    };
  void _saveForm()async{
   if(!_transportForm.currentState!.validate()){
     return;
   }
    _transportForm.currentState!.save();
  setState(() {
    _loading=true;
  });
      try {
        _transport["dateArrive"]=_selectedDate.toString().split(" ")[0];
          _transport["retour"]=_isChecked;
        await Provider.of<Transports>(context, listen: false)
            .addTransport(_transport);
      } catch (error) { 
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occurred!'),
                content: const Text('Something went wrong.'),
                actions: <Widget>[
                  TextButton(
                    child:const Text('Okay'),
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
     Navigator.of(context).pop();
      // Navigator.pushAndRemoveUntil(
      // context,
      // MaterialPageRoute(
      //   builder: (BuildContext context) => ShippingScreen(),
      // ),
      // ModalRoute.withName('/'));
      //remove until home and push /manage clients again
    
  }


  @override
  Widget build(BuildContext context) {
    return _loading?const Center(child: CircularProgressIndicator(),) 
    :Container(
              padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
              margin:const EdgeInsets.only(left:20,right: 20,top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
                  
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height),
                      child: Column(
                        children: [
                          Image.asset('assets/images/shipping_icon2.png'),
                       Expanded(
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _transportForm,
                                        child: Column(
                                          children: <Widget>[
                                            CustomTextField('Producer',_transport["producer"],2,TextInputType.text,
                                            (value)=>Validator.validateGeneral(value),
                                            (value){
                                              _transport["producer"]=value;
                                            }),
                                            CustomTextField('Driver name',_transport["driverName"],1,TextInputType.text,
                                             (value)=>Validator.validateGeneral(value),
                                            (value){
                                               _transport["driverName"]=value;
                                            }),
                                            CustomTextField('Driver phone number',_transport["driverPhoneNumber"],1,TextInputType.text,
                                            (value)=>Validator.validatePhoneNumber(value),
                                            (value){
                                               _transport["driverPhoneNumber"]=value;
                                            }),
                                            CustomTextField('Truck registration number', _transport["truckRegistrationNumber"],1,TextInputType.text,
                                            (value)=>Validator.validateRegisterNumber(value),
                                            (value){
                                               _transport["truckRegistrationNumber"]=value;
                                            }),
                                            Row(children: <Widget>[
                                              const Text('Retour',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                                              Checkbox(
      checkColor: Colors.yellow,
      activeColor: Colors.green,
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
         
        });}),
                                            ],),
                                      Container(
          decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(left: 30, right: 30),
          height: 70,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                ),
              ),
              TextButton(
                child: const Text(
                  'Choose Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _presentDatePicker,
              ),
            ],
          ),
        ),       
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                 ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text('Cancel')),
                                                ElevatedButton(onPressed: ()=>_saveForm(), child: const Text('Add')),
                                               
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
  Widget CustomTextField(String title,dynamic initialValue,int lines,TextInputType inputType,Function validationHandler,Function saveHandler) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
                      initialValue: initialValue.toString(),
                      maxLines: lines,
                      decoration:  InputDecoration(
                        fillColor:const Color.fromARGB(238, 255, 255, 255),
                        filled: true,
                        labelStyle: const TextStyle(color:Color.fromRGBO(72, 40, 74, 1),
                        fontWeight: FontWeight.bold
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
    
                onFieldSubmitted: (_){
                    setState(() {
                      FocusScope.of(context).unfocus();
                    });
                },
                validator: (value)=>validationHandler(value),
                      onSaved: (value)=>saveHandler(value),
                    ),
    );
  }
    void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}
