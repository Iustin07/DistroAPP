import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
import '../utils/validation.dart';
class AddEmployerScreen extends StatefulWidget {
  const AddEmployerScreen({Key? key}) : super(key: key);
static const routeName="/add-employee";


  @override
  State<AddEmployerScreen> createState() => _AddEmployerScreenState();
}

class _AddEmployerScreenState extends State<AddEmployerScreen> {
    String? roleName = 'Handler';
    String? license='None';
    final _employeForm = GlobalKey<FormState>();
    Map<String,dynamic> employeeValues={
      'username':'',
      'passwordHash':'',
      'phoneNumber':'',
      'address':'',
      'userRole':'',
      'salary':0.0,
      'driverLicense':''

    };
    bool _loading=false;
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Future <void> _saveForm() async{
    if(!_employeForm.currentState!.validate()){
      return;
    }
    _employeForm.currentState!.save();
    setState(() {
      _loading=true;
    });
    try {
        await Provider.of<Users>(context, listen: false)
            .addEmploye(employeeValues);
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
        _loading=false;
      });
      
  }
  @override
  Widget build(BuildContext context) {
    
 
    return
      Scaffold(
        appBar: AppBar(title: const Text('Add employee'),),
        body:_loading? const Center(child: CircularProgressIndicator(),) 
        :Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Form(
                key: _employeForm,
                child: ListView(
                  children: <Widget>[
                    TextFormFieldWidget('Username',1,false, TextInputType.text, (value)=>Validator.validateGeneral(value), 
                      (value)=>employeeValues["username"]=value),
                    TextFormFieldWidget('Password',1,true, TextInputType.text, (value)=>Validator.validatePassword(value), 
                      (value)=>employeeValues["passwordHash"]=value),
                    TextFormFieldWidget('Phone number',1,false, TextInputType.text, (value)=>Validator.validatePhoneNumber(value), 
                      (value)=>employeeValues["phoneNumber"]=value),
                    TextFormFieldWidget('Address',3,false, TextInputType.text, (value)=>Validator.validateGeneral(value), 
                      (value)=>employeeValues["address"]=value),
                    
                    Row(
                      children: <Widget>[
                       const  Text('Role',style: TextStyle(color: Colors.white,fontSize: 16),),
                        const SizedBox(width: 7,),
                        DropdownButton<String>(
                          style:const TextStyle(color:Colors.white70, fontSize: 16,
                          fontWeight: FontWeight.w500),
                          focusColor: Colors.white60,
                          dropdownColor:const Color.fromARGB(255,30, 161, 217),
                          items: <String>['Accountant', 'Driver', 'Agent','Storeman','Handler','Manager'].map((value) {
                            return DropdownMenuItem(value: value, 
                            child: Text(value,style: const TextStyle(color: Colors.white),));
                          }).toList(),
                          value: roleName,
                          onChanged: (item) => setState(() {
                            employeeValues["userRole"]=item?.toLowerCase();
                            roleName = item;
                          }),
                          icon: const Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
             TextFormFieldWidget('Wage',1,false,TextInputType.number,
             (value)=>Validator.validateDouble(value),
             (value)=>employeeValues["salary"]=value
             ),
                    Row(
                      children: <Widget>[
                        const Text('Driver license',style: TextStyle(color: Colors.white,fontSize: 16),),
                        const SizedBox(width: 7, ),
                        DropdownButton<String>(
                          style:const TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor: const Color.fromARGB(255,30, 161, 217),
                          items: <String>['None','B','C', 'CE'].map((value) {
                            return DropdownMenuItem(value: value,
                             child: Text(value, style:const TextStyle(color: Colors.white)));
                          }).toList(),
                          value: license,
                          onChanged: (value) => setState(() {
                            license = value;
                            employeeValues["driverLicense"]=value;
                          }),
                          icon: const Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                   const SizedBox(height: 5, ),                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                         ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text('Cancel')),
                        ElevatedButton(onPressed: () {
                          _saveForm();
                        }, child: const Text('Add')),
                       
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  
  }

  TextFormField TextFormFieldWidget(String? title,int? lines,bool obscure,TextInputType type,Function validateHandler,Function saveHandler) {
    return TextFormField(
       obscureText: obscure,
      maxLines: lines,
                    decoration:  InputDecoration(
                      fillColor: const Color.fromARGB(255, 30, 161, 217),
                      filled: true,
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: title,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.black45, width: 2.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:  BorderSide(
                              color: Colors.cyanAccent, width: 2.0)),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType:type ,
                    validator: (value)=>validateHandler(value),
                    onSaved: (value)=>saveHandler(value),
                  );
  }
}