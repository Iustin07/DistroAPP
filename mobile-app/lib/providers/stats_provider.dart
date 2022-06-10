import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
class Stats with ChangeNotifier{
Map<String, double> _monthlyStats={};
Map<String, double>get getMonthlyStats{
  return {..._monthlyStats};

}  
Future<void> readJson() async {
    final String response = await rootBundle.loadString('lib/data/monthly_stats.json');
    _monthlyStats=Map.castFrom(await json.decode(response));
  notifyListeners();
}
 double get maxSpending {

    return _monthlyStats.isEmpty?0.0:
    _monthlyStats.values.fold(0.0,(maxitem,item)=>item >(maxitem as double)  ? item :maxitem);
  }

}