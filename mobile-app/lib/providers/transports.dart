import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/transport.dart';
import '../properties.dart';
import 'package:http/http.dart' as http;
import '../model/transport_item.dart';
import '../model/review.dart';
class Transports with ChangeNotifier{
  String? _token;
  Transports(this._token);
Future<List<Transport>> fetchTransports(bool received) async {
    final url = Uri.parse('$serverUrl/transports/all?received=$received');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);

      return data.map((e) => Transport.mapJsonToTransport(e),).toList();
    } catch (error) {
      throw (error);
    }
  
    
}

// Future<List<Transport>> fetchWaitingTransports() async {
//     final String response = await rootBundle.loadString('lib/data/waitingtransports.json');
//     Iterable data=json.decode(response);
//     return data.map((e) => Transport.mapJsonToTransport(e),).toList();
// }
Future<dynamic> addTransport(Map transportData)async{
  final url = Uri.parse('$serverUrl/transports');
    try {
      final response =
          await http.post(url, headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $_token'
            },
            body: json.encode(transportData)
            );
      return response.statusCode;
     
    } catch (error) {
      throw (error);
    }
}

Future <dynamic> updateTransport(int transportId,List<TransportItem> items,double totalValue,Review? review)async{
final url=Uri.parse("$serverUrl/transports/$transportId");
        try {
      final response = await http.patch(
        url,
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode({
          "valueOfProducts":totalValue,
          "products":items,
          "review":review,
        }),
      );
    
       return response.statusCode;
    } catch (error) {
      print(error);
      throw error;
    }
}
}