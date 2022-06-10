import 'dart:ffi';

import '../model/client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
class Clients with ChangeNotifier{
   List<Client> _clients=[];
   List<Client> get clients{
     return[..._clients];
   }
  Clients(this._token);
  String _token;
  Future<void> fetchAndSetClients(bool enabled) async {
    final url = Uri.parse('http://192.168.0.103:3000/clients/?enabled=$enabled');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
    _clients = data.map((e) => Client.mapJsonToClient(e)).toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
    Future<Map<int,String>> getClients() async {
    Map<int,String> results={};
    final url = Uri.parse('http://192.168.0.103:3000/clients/?enabled=true');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      data.forEach((client) =>results.putIfAbsent(client["idClient"], () => client["clientName"]) );
      print(results);
      notifyListeners();
      return results;
    } catch (error) {
      throw (error);
    }
  
  }
  Future<dynamic> enableClient(Client client) async{
 final url=Uri.parse('http://192.168.0.103:3000/clients/?id=${client.id}');
 try {
      final response =
          await http.patch(url, headers: {'Authorization': 'Bearer $_token'});
      notifyListeners();
      if (response.statusCode==200){
        return 200;
      }
    } catch (error) {
      throw (error);
    }
   
  }
    Future<dynamic> addClient(Map jsonData) async{
    final url=Uri.parse('http://192.168.0.103:3000/clients');
    try {
      final response =
          await http.post(url,
          
           headers: {'Content-type':"application/json",
             'Authorization': 'Bearer $_token'},
            body: json.encode(jsonData), 
             );
      print(response.body);  
      notifyListeners();
    } catch (error) {
      throw (error);
    }
   
  }

}