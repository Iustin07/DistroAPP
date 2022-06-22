import '../properties.dart';
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
    final url = Uri.parse('$serverUrl/clients/?enabled=$enabled');
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
    final url = Uri.parse('$serverUrl/clients/?enabled=true');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      data.forEach((client) =>results.putIfAbsent(client["idClient"], () => client["clientName"]) );
      notifyListeners();
      return results;
    } catch (error) {
      throw (error);
    }
  
  }
  Future<dynamic> enableClient(Client client) async{
 final url=Uri.parse('$serverUrl/clients/?id=${client.id}');
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
    final url=Uri.parse('$serverUrl/clients');
    try {
      final response =
          await http.post(url,
           headers: {'Content-type':"application/json",
             'Authorization': 'Bearer $_token'},
            body: json.encode(jsonData), 
             ); 
      notifyListeners();
      return response.body;
    } catch (error) {
      throw (error);
    }
   
  }
  Future<dynamic> deleteClient(int clientId)async{
    final clientIndex=_clients.indexWhere((element) => element.id==clientId);
     final url=Uri.parse('$serverUrl/clients/${clientId}');
 try {
      final response =
          await http.delete(url, headers: {'Authorization': 'Bearer $_token'});
          if(response.statusCode==200){
            _clients.removeAt(clientIndex);
            notifyListeners();
              return 200;
            }else{
              return 400;
            }
     
    } catch (error) {
      throw (error);
    }
  }
  Future<void> updateClient(int clientId, Map client)async{
  final clientIndex=_clients.indexWhere((element) => element.id==clientId);
final url = Uri.parse('$serverUrl/clients/$clientId');
     try {
       final response=await http.patch(
        url,  
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode(client),
      );
      if(response.statusCode==200){
      _clients[clientIndex]=Client.mapJsonToClient(client);
       notifyListeners();}
    } catch (error) {
      throw error;
    }
  }
  void clear(){
    if (!_clients.isEmpty)
    _clients.clear();
    
  }
}