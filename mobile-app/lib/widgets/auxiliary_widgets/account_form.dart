
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '../../providers/users.dart';
import '../../providers/authentification.dart';

class AccountForm extends StatefulWidget {
  AccountForm({Key? key}) : super(key: key);

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final _screenFocus = FocusNode();
  final _currentPassword = FocusNode();
  final _confirmCurrentPassword = FocusNode();
  final _newPassword = FocusNode();
  final _confirmNewPassword = FocusNode();
  final _formAccount = GlobalKey<FormState>();
  bool _loading = false;
  String? _currentPasswordText;
  String? _confirmCurrentPasswordText;
  String? _newPasswordText;
  String? _confirmNewPasswordText;
  bool _isMatch = true;
  bool _showedSnackBar=false;
  Future<dynamic> _saveForm(BuildContext context) async {
    if (!_formAccount.currentState!.validate()) {
      return;
    }
    _formAccount.currentState!.save();
    if (_currentPasswordText != _confirmCurrentPasswordText) {
           setState(() {
                _isMatch = false;
              });
      _showAlertBox("Current  passwords do not match");
    }
    if (_newPasswordText != _confirmNewPasswordText) {
           setState(() {
                _isMatch = false;
              });
      _showAlertBox("new password does not match");
    }
    if (_isMatch) {
      setState(() {
        _loading = true;
      });
      
      try {
        final response=await Provider.of<Users>(context,listen: false).resetPasswordRequest(
          {"oldPassword":_currentPasswordText,
          "newPassword":_newPasswordText
          });
          if(response=="OK"){
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Password was reset sucessfully',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
            
          }else
          {_showAlertBox(response);

          }
      } catch (error) {
        throw(error);
      }
      setState(() {
        _loading = false;
      });
     Future.delayed(const Duration(seconds: 2),(){
       Navigator.of(context).popUntil(ModalRoute.withName("/"));
      Provider.of<Authentication>(context, listen: false).logout();
     });
      
      
    }
    setState(() {
      _isMatch=true;
    });
  }

  void _showAlertBox(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('An Error Occurred!', style: TextStyle(color: Colors.white),),
        content: Text(message, style: const TextStyle(color:Colors.white),),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _screenFocus.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    _confirmCurrentPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Form(
                  key: _formAccount,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFormField('Current password', _currentPassword,
                          (value) => generalValidation(value,false), (value) {
                        _currentPasswordText = value;
                      }),
                      CustomTextFormField(
                          'Confirm current password',
                          _confirmCurrentPassword,
                          (value) => generalValidation(value,false), (value) {
                        _confirmCurrentPasswordText = value;
                      }),
                      CustomTextFormField('New password', _newPassword,
                          (value) => generalValidation(value,true), (value) {
                        _newPasswordText = value;
                      }),
                      CustomTextFormField(
                          'Confirm new password',
                          _confirmNewPassword,
                          (value) => generalValidation(value,true), (value) {
                        _confirmNewPasswordText = value;
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () => _saveForm(context),
                              child: const Text('Save')),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
    
  }

  Padding CustomTextFormField(String? titleLabel, FocusNode node,
      Function validatorHandler, Function saveHandler) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        obscureText: true,
        decoration: InputDecoration(
          fillColor:const  Color.fromARGB(255, 30, 161, 217),
          filled: true,
          labelStyle: const TextStyle(color: Colors.white),
          labelText: titleLabel,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black45, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide:
                  BorderSide(color: Colors.cyanAccent, width: 2.0)),
        ),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        focusNode: node,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus();
        },
        validator: (value) => validatorHandler(value),
        onSaved: (value) => saveHandler(value),
      ),
    );
  }

  String? generalValidation(dynamic value, bool changer) {
    if (value.toString().length < 8 || value.toString().isEmpty) {
      return 'password is not long enough';
    }
    if(changer)
    if (!RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
        .hasMatch(value.toString())) {
      return "password must contain at least a caiptal letter and a number";
    }
  }
}
