import 'package:distroapp/model/custom_centralizer.dart';
import '../model/summar.dart';
import '../model/centralizer.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../properties.dart' show serverUrl;
import 'package:http/http.dart' as http;
import '../properties.dart';
class Centralizers with ChangeNotifier {
  List<Centralizer> _centralizers = [];
  List<Summar> _summary = [];
  List<int> ordersId = [];
  String _token;
  Centralizers(this._token);

  List<Centralizer> get centralizers {
    return [..._centralizers];
  }

  List<Summar> get summary {
    return [..._summary];
  }

  Future<dynamic> addCentralizer(Iterable<CustomItem> ordersIds, int driverId) async {
    final url = Uri.parse('$serverUrl/centralizers');
    try {
      final ids=ordersIds.map((e) => e.orderId).toList();
      final response =
          await http.post(url, headers: {
            'Content-type':'application/json',
            'Authorization': 'Bearer $_token'},
          body: json.encode({
            "deliverDriver":driverId,
            "ordersIds": ids
          })
          );
      notifyListeners();
      if (response.statusCode == 200)
        return 200;
      else
        return response.statusCode;
    } catch (error) {
      throw (error);
    }
  }

  Future<List<Summar>> readSummar(int id) async {
    final url =
        Uri.parse('$serverUrl/centralizers/summarize/$id');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
     return data.map((e) => getSummarFromJsom(e)).toList();
     
    } catch (error) {
      throw (error);
    }
  }

  Summar getSummarFromJsom(Map json) {
    return Summar(
        json["productName"], DividerObject.mapJsonToDivider(json["summar"]));
  }

Future<List<Centralizer>> fetchCentralizers() async {
  final url=Uri.parse("$serverUrl/centralizers/all");
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      return  data.map((e) => Centralizer.mapJsonToObeject(e)).toList();
      
    } catch (error) {
      throw (error);
    }
 
}
Future<Centralizer> fectchById(int id)async{
  final url=Uri.parse('$serverUrl/centralizers/$id');
  try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
          print(response.body);
      Map data = json.decode(response.body);
      return  Centralizer.mapJsonToObeject(data);
      
    } catch (error) {
      throw (error);
    }
}
Future <List<Centralizer>> fetchCentralizersByDateAndDriver(String date)async{
final url=Uri.parse('${serverUrl}/centralizers/driver?date=$date');
try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      return  data.map((e) =>Centralizer.mapJsonToObeject(e)).toList();
      
    } catch (error) {
      throw (error);
    }
}




  

}
