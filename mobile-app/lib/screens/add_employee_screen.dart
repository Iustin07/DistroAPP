import '../model/employe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';
class AddEmployerScreen extends StatefulWidget {
  AddEmployerScreen({Key? key}) : super(key: key);
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
    //form validations
    _employeForm.currentState!.save();
    print(employeeValues);
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
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
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
      
  }
  @override
  Widget build(BuildContext context) {
    
 
    return
      Scaffold(
        appBar: AppBar(title: Text('Add employee'),),
        body:_loading? Center(child: CircularProgressIndicator(),) 
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
                    TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 30, 161, 217),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Username',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: const BorderSide(
                                color: Colors.cyanAccent, width: 2.0)),
                      ),
                      textInputAction: TextInputAction.next,
                  
                      onSaved: (value) {
                        employeeValues["username"]=value;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255,30, 161, 217),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: const BorderSide(
                            color: Colors.cyanAccent, width: 2.0)),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,                
                      onSaved: (value) {
                        employeeValues["passwordHash"]=value;
                      },
                    ),
                       TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 30, 161, 217),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Phone number',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: const BorderSide(
                                color: Colors.cyanAccent, width: 2.0)),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        employeeValues["phoneNumber"]=value.toString();
                      },
                    ),
                       TextFormField(
                         maxLines: 3,
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 30, 161, 217),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Address',
            
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: const BorderSide(
                                color: Colors.cyanAccent, width: 2.0)),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        employeeValues["address"]=value;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Text('Role',style: TextStyle(color: Colors.white,fontSize: 16),),
                        SizedBox(
                          width: 7,
                        ),
                        DropdownButton<String>(
                          style:TextStyle(color:Colors.white70, fontSize: 16,
                          fontWeight: FontWeight.w500),
                          focusColor: Colors.white60,
                          dropdownColor:Color.fromARGB(255,30, 161, 217),
                          items: <String>['Accountant', 'Driver', 'Agent','Storeman','Handler'].map((value) {
                            return DropdownMenuItem(value: value, 
                            child: Text(value,style: TextStyle(color: Colors.white),));
                          }).toList(),
                          value: roleName,
                          onChanged: (item) => setState(() {
                            employeeValues["userRole"]=item?.toLowerCase();
                            roleName = item;
                          }),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
             TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 30, 161, 217),
                        filled: true,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Wage',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(color: Colors.black45, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: const BorderSide(
                                color: Colors.cyanAccent, width: 2.0)),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        employeeValues["salary"]=value;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Text('Driver license',style: TextStyle(color: Colors.white,fontSize: 16),),
                        SizedBox(
                          width: 7,
                        ),
                        DropdownButton<String>(
                          style:TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor: Color.fromARGB(255,30, 161, 217),
                          items: <String>['None','B','C', 'CE'].map((value) {
                            return DropdownMenuItem(value: value,
                             child: Text(value, style:TextStyle(color: Colors.white)));
                          }).toList(),
                          value: license,
                          onChanged: (value) => setState(() {
                            license = value;
                            employeeValues["driverLicense"]=value;
                          }),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                         ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Cancel')),
                        ElevatedButton(onPressed: () {
                          _saveForm();
                        }, child: Text('Add')),
                       
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
}