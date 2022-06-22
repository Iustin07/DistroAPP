import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import'dart:convert';
import '../properties.dart';
import '../model/employe.dart';
import '../model/custom_employe.dart';
import '../model/httpexception.dart';
class Users with ChangeNotifier{
  String _token;
  Users(this._token);
   List<CustomEmployee> _allEmployee = [];
  List<CustomEmployee>get allEmployee{
    return [... _allEmployee];
  }
    Future<void> fetchCustomEmployee() async {
    final url = Uri.parse('$serverUrl/users/all');
    try {
      final response = await http.get(url,
      headers: {'Authorization': 'Bearer $_token'});
      Iterable data=json.decode(response.body);
      _allEmployee=data.map((e) =>getCustomFromJsom(e)).toList();
  notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  CustomEmployee getCustomFromJsom(Map json){
    return CustomEmployee(json["userId"],json["username"]);
  }
  Future<Employee> findEmployeeById(int id)async{
final url = Uri.parse('h$serverUrl/users/$id');
    try {
      final response = await http.get(url,
      headers: {'Authorization': 'Bearer $_token'});
      var data=json.decode(response.body);
      notifyListeners();
      return Employee.mapJsonToEmployee(data);
  
    } catch (error) {
      throw (error);
    }
  }
  Future <void> addEmploye(Map datajson) async{
    final url=Uri.parse("$serverUrl/users");
        try {
      final response = await http.post(
        url,
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode(datajson),
      );
       notifyListeners();
    } catch (error) {
      throw error;
    }
  }
  Future<void> updateEmployee(int id,String address, String phoneNumber,double salary,String driverLicense) async{
    final url = Uri.parse('$serverUrl/users/$id');
     try {
       await http.patch(
        url,
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode({
          "address":address,
          "phoneNumber":phoneNumber,
          "salary":salary,
          "driverLicense":driverLicense
        }),
      );
       notifyListeners();
    } catch (error) {
      throw error;
    }
  }
    Future<void> deleteEmploye(int id) async {
    final url = Uri.parse('$serverUrl/users/$id');
    final employ=_allEmployee.firstWhere((element) => element.employeeId==id);
    _allEmployee.removeWhere((element) => element.employeeId==id);
    notifyListeners();
    final headers={"Content-type": "application/json",
      "Authorization": 'Bearer $_token'};
    final response = await http.delete(url,headers: headers);
    if (response.statusCode >= 400) {
      _allEmployee.insert(0,employ);
      notifyListeners();
      throw HttpException('Could not delete user.');
    }
    
  }

Future<dynamic> resetPasswordRequest(Map jsondata) async{
final url=Uri.parse("$serverUrl/users/reset");
final response=await http.patch(url,
headers: {'Content-type': 'application/json',
  'Authorization':'Bearer $_token'},
body: json.encode(jsondata)
);
if(response.statusCode==403){
  return response.body;
}
if(response.statusCode==200){
  return 'OK';
}

}

Future<List<CustomEmployee>> getSpecificRequest(String role) async {
    final url = Uri.parse('$serverUrl/users/custom?role=$role');
    try {
      final response = await http.get(url,
      headers: {'Authorization': 'Bearer $_token'});
      Iterable data=json.decode(response.body);
      return data.map((e) =>getCustomFromJsom(e)).toList();
    } catch (error) {
      throw (error);
    }
    
  }
Future<double> getWages()async{
  final url = Uri.parse('$serverUrl/users/wage');
    try {
      final response = await http.get(url,
      headers: {'Authorization': 'Bearer $_token'});
      dynamic data=json.decode(response.body);
      return data;
    } catch (error) {
      throw (error);
    }
}
 void clear(){
   _allEmployee.clear();
   notifyListeners();
 }
 
}