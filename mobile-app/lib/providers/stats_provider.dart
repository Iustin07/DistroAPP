import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../properties.dart';
class Stats with ChangeNotifier{
  String _token;
  Stats(this._token);
Map<String, double> _monthlyStats={};
Map<String, double>get getMonthlyStats{
  return {..._monthlyStats};

}  
// Future<void> readJson() async {
//     final String response = await rootBundle.loadString('lib/data/monthly_stats.json');
//     _monthlyStats=Map.castFrom(await json.decode(response));
//   notifyListeners();
// }
Future<dynamic> getMonthlyStat()async{
      final url=Uri.parse("$serverUrl/orders/anual");
        try {
      final response = await http.get(url,
        headers: {'Authorization':'Bearer $_token'},
       );
       _monthlyStats=Map.castFrom( json.decode(response.body));
       return(response.statusCode);
    } catch (error) {
      print(error);
      throw error;
    }
}
 double get maxSpending {

    return _monthlyStats.isEmpty?0.0:
    _monthlyStats.values.fold(0.0,(maxitem,item)=>item >(maxitem as double)  ? item :maxitem);
  }

}