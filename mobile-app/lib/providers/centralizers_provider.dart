import 'package:distroapp/model/custom_centralizer.dart';

import '../model/summar.dart';
import '../model/centralizer.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/order.dart';
import 'package:flutter/foundation.dart';
import '../model/client.dart';

import 'package:http/http.dart' as http;

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
    final url = Uri.parse('http://192.168.0.103:3000/centralizers');
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
    print('called summar fetch');
    print(id);
    final url =
        Uri.parse('http://192.168.0.103:3000/centralizers/summarize/$id');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      print(response.body);
     return data.map((e) => getSummarFromJsom(e)).toList();
     
    } catch (error) {
      throw (error);
    }
  }

  Summar getSummarFromJsom(Map json) {
    return Summar(
        json["productName"], json["quantity"] as int, json["measureUnit"]);
  }

Future<List<Centralizer>> fetchCentralizers() async {
  print('fetch centralizers called');
  final url=Uri.parse("http://192.168.0.103:3000/centralizers/all");
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
      return  data.map((e) => getCentralizer(e)).toList();
      
    } catch (error) {
      throw (error);
    }
 
}





  Centralizer getCentralizer(Map json) {
    return Centralizer(
        centralizerId: json["id"],
        driverName: json["driverName"],
        date: json["creationDate"],
        orders: getOrderFromJson(json["orders"]));
  }

  List<Order> getOrderFromJson(Iterable data) {
    return data
        .map((json) => Order.all(
            orderId: json["order"]["orderId"],
            date: json["order"]["orderData"],
            orderSellerAgent: json["order"]["orderSellerAgent"],
            client: getClientFromJson(json["order"]["client"]),
            orderPaymentValue: json["order"]["orderPaymentValue"],
            totalWeight: json["order"]["totalWeight"],
            orderProducts: []))
        .toList();
  }

  Client getClientFromJson(Map clientjson) {
    return Client.all(
        clientjson["idClient"],
        clientjson["clientName"],
        clientjson["cif"],
        clientjson["commerceRegistrationNumber"],
        clientjson["adress"],
        clientjson["clientPhoneNumber"],
        clientjson["longitude"],
        clientjson["latitude"]);
  }

}
