import  'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../properties.dart';
class Authentication with ChangeNotifier{
String? _token;
DateTime? _expiryDate;
String? _username;
String? _role;
int? _userid;
Timer? _authTimer;
//Timer _authTimer;
String get getRole{
  return _role!;
}
bool get isAuth{
  return token != '';
}
String get token{
  if(_expiryDate!=null && _expiryDate!.isAfter(DateTime.now()) && _token!=''){
    return _token!;
  }
  return '';
}
String get username{
  return _username!;
}
int get userId{
  return _userid as int;
}
Future<void> _authenticate(String username, String password) async{
final url=Uri.parse('$serverUrl/authenticate');
print('${username} ${password}');
print(json.encode({
  'userName':username.toString(),
  'userPassword':password.toString(),
}));
 final headers = {"Content-type": "application/json"};
final response=await http.post(url,
body: json.encode({
  'userName':username,
  'userPassword':password,
}),
headers: headers
); 
_token=jsonDecode(response.body)['token'] as String;
print(json.decode(response.body));
Map<String,dynamic> payload=JwtDecoder.decode(_token as String);
// for(var  entry in payload.entries){
// print('${entry.value} ${entry.value.runtimeType}');
// }
_userid=payload["id"];
_role=payload["role"];
_expiryDate=DateTime.now().add(
  Duration(
    seconds: payload["exp"]
  ),
);
notifyListeners();
}
Future<void>login(String username,String password)async{
  return _authenticate(username, password);
}
void logout(){
  _token=null;
  _userid=null;
  _expiryDate=null;
notifyListeners();
}
}