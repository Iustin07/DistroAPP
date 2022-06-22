import 'package:distroapp/utils/validation.dart';

import '../screens/after_login.dart';
import 'package:flutter/material.dart';
import '../providers/authentification.dart';
import 'package:provider/provider.dart';
import '../model/httpexception.dart';

class AuthForm extends StatefulWidget {
  AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authentificationData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Authentication>(context, listen: false).login(
        _authentificationData['username']!,
        _authentificationData['password']!,
      );
    } on HttpException catch (error) {
      var errorMessage = 'authetification failed';
      _showErrorDialog(errorMessage);
    } catch (error) {
      print(error.toString());
      const errorMessage = 'Could not authentificate.please try again later. Check username or password';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      primary: Theme.of(context).primaryColor,
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: 260,
        constraints: const BoxConstraints(minHeight: 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.text,
                    validator: (value) =>Validator.validateUserName(value),
                    onSaved: (value) {
                      _authentificationData['username'] =
                          value.toString().trim();
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: (value)=>Validator.validatePassword(value),
                    onSaved: (value) {
                      _authentificationData['password'] =
                          (value as String).trim();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: _submit,
                      child: const Text('Login'),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
