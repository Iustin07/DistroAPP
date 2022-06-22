import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "dart:math";
import "../../model/employe.dart";
import '../../providers/users.dart';

class EmployeDetailsBody extends StatefulWidget {
  const EmployeDetailsBody({
    Key? key,
    this.employeId,
    this.deviceHeight,
    this.deviceWidth,
  }) : super(key: key);
  final employeId;
  final deviceHeight;
  final deviceWidth;
  @override
  State<EmployeDetailsBody> createState() => _EmployeDetailsBodyState();
}

class _EmployeDetailsBodyState extends State<EmployeDetailsBody> {
  bool _showFront = true;
  bool _flipXAxis = true;
  String? _license = 'None';
  late String _address;
  late String _phoneNumber;
  late double _salary;
  bool _loading = false;
  bool _init = true;
  late Employee? employee;
  final _employeModifyForm = GlobalKey<FormState>();
  @override
  void dispose() {
    _address='';
    _phoneNumber='';
    _salary=0;
    employee=null;
    super.dispose();
  }
  void initState() {
    _showFront = true;
    _flipXAxis = true;
    if (_init) {
      setState(() {
        _loading = true;
      });
      final employeeFuture = Provider.of<Users>(context, listen: false)
          .findEmployeeById(widget.employeId)
          .then((value) {
        setState(() {
          employee = value;
          _license =
              employee!.driverLicense == null ? 'None' : employee!.driverLicense;
          _address = employee!.address;
          _salary = employee!.salary;
          _phoneNumber = employee!.phoneNumber;
          _loading = false;
        });
      });
    }
    _init = false;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }
 Future<void> _fireEmployee(int id) async{
      setState(() {
      _loading = true;
    });
   try {
       await Provider.of<Users>(context, listen: false).deleteEmploye(id);
    } catch (error) {
      throw(error);
      
      }
      setState(() {
      _loading = false;
    });
    Navigator.of(context).pop();
 }
  Future<void> _saveForm() async {
    //validari
    _employeModifyForm.currentState!.save();
    setState(() {
      _loading = true;
    });
    try {
      print('${_address} ${_license} ${_phoneNumber}');
       await Provider.of<Users>(context, listen: false)
           .updateEmployee(widget.employeId,_address,_phoneNumber,_salary,_license as String);
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title:const Text('An error occurred!'),
          content:const  Text('Something went wrong.'),
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
      _loading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 150, right: 10, left: 10),
            child: _buildFlipAnimation(
                widget.deviceWidth, widget.deviceHeight, employee as Employee),
          );
    ;
  }

  void _changeRotation() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchFace() {
    setState(() {
      _showFront = !_showFront;
    });
  }

//cod preluat de pe https://medium.com/flutter-community/flutter-flip-card-animation-eb25c403f371
  Widget _buildFlipAnimation(
      double deviceWidth, double deviceHeight, Employee employee) {
    return GestureDetector(
      onTap: _switchFace,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _showFront
            ? _frontFace(deviceWidth, deviceHeight, employee)
            : _backFace(deviceWidth, deviceHeight, employee),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFront) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  //
  Container _backFace(
      double deviceWidth, double deviceHeight, Employee employee) {
    return Container(
        key: ValueKey(false),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blue,
        ),
        margin:const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: deviceWidth * 0.3,
                  height: deviceHeight * 0.1,
                )
              ],
            ),
            Expanded(
                flex: 1,
                child: Form(
                    key: _employeModifyForm,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            initialValue: employee.address,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 30, 161, 217),
                              filled: true,
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: 'Address',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: const BorderSide(
                                      color: Colors.cyanAccent, width: 2.0)),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              _address = value as String;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            initialValue: employee.phoneNumber,
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 30, 161, 217),
                              filled: true,
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: 'Phone number',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:  BorderSide(
                                      color: Colors.cyanAccent, width: 2.0)),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _phoneNumber = value as String;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            initialValue: employee.salary.toString(),
                            decoration: const InputDecoration(
                              fillColor: Color.fromARGB(255, 30, 161, 217),
                              filled: true,
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: 'Wage',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.black45, width: 2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:  BorderSide(
                                      color: Colors.cyanAccent, width: 2.0)),
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _salary = double.parse(value as String);
                            },
                          ),
                        ),
                       const SizedBox( height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                             const  Text(
                                'Driver license',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(width: 7,),
                              DropdownButton<String>(
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 16),
                                focusColor: Colors.white60,
                                dropdownColor:
                                const    Color.fromARGB(255, 30, 161, 217),
                                items: <String>['None', 'B', 'C', 'CE']
                                    .map((value) {
                                  return DropdownMenuItem(
                                      value: value,
                                      child: Text(value,
                                          style:
                                              const TextStyle(color: Colors.white)));
                                }).toList(),
                                value: _license,
                                onChanged: (value) => setState(() {
                                  _license = value;
                                }),
                                icon: const Icon(Icons.arrow_drop_down_circle),
                              ),
                            ],
                          ),
                        ),
                       const SizedBox( height: 10, ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child:const Text('Cancel')),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor),
                                ),
                                onPressed: () {
                                  _fireEmployee(widget.employeId);
                                },
                                child:const Text('Fire')),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor),
                                ),
                                onPressed: () {
                                  _saveForm();
                                },
                                child:const Text('Save')),
                          ],
                        ),
                      ],
                    )))
          ],
        ));
  }

  Widget _frontFace(
      double deviceWidth, double deviceHeight, Employee employee) {
    return Container(
      key: ValueKey(true),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: deviceWidth * 0.3,
                height: deviceHeight * 0.1,
              )
            ],
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Center(
              child: Container(
                  color: Colors.white70,
                  child:const Icon(
                    Icons.person_sharp,
                    size: 150,
                    color: Colors.blue,
                  )),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.00),
              ),
              width: 300,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                      child: Column(
                    children: [
                      const Text(
                        'Employe name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        employee.username,
                        style:const  TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Role',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          employee.userRole.toUpperCase(),
                          style:const  TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    employee.createdOn.split(".")[0],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
