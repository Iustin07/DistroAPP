import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../model/lost.dart';
import '../properties.dart';
class Losts with ChangeNotifier{
String _token;
Losts(this._token);

Future<List<Lost>> fetchLostsRequestedUser() async{
final url=Uri.parse('$serverUrl/loses/specific');
try{
 final response= await http.get(url,
 headers: {'Authorization':'Bearer $_token'});
  Iterable data=json.decode(response.body);
  return data.map((e) => Lost.mapFromJsonToLost(e)).toList();
}catch(error){
  throw error;
}
}
Future<List<Lost>> fetchLostsBySpecifiedPeriod(String firstDate, String secondDate) async{
final url=Uri.parse('$serverUrl/loses/all?firstDate=$firstDate&secondDate=$secondDate');
try{
 final response= await http.get(url,
 headers: {'Authorization':'Bearer $_token'});
  Iterable data=json.decode(response.body);
  return data.map((e) => Lost.mapFromJsonToLost(e)).toList();
}catch(error){
  throw error;
}
}
Future<dynamic> addLost(int productId, double quantity)async{
final url=Uri.parse('$serverUrl/loses');
try{
  final response=await http.post(url,
  headers: {'Authorization':'Bearer $_token',
  "Content-type": "application/json"},
  body: json.encode({
    "productId":productId,
    "quantity":quantity
  }));
  if(response.statusCode==200){
    return 200;
  }else{
    return 400;
  }
}catch(error){
  throw error;
}

}
}





