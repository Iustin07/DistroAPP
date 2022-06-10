import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chart_bar.dart';
import 'dart:math';
import '../../providers/stats_provider.dart';
class Chart extends StatelessWidget {

  Chart({Key? key}) : super(key: key);
Map<String,double> _stats={};

  @override
  Widget build(BuildContext context) {
    Provider.of<Stats>(context).readJson();
     final _stats=Provider.of<Stats>(context).getMonthlyStats;
     final maxSpending=Provider.of<Stats>(context,listen: false).maxSpending;
    return Card(
      elevation: 6,
      //margin: EdgeInsets.all(15),
      child: Padding(padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _stats.entries.map((entry) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
               label: entry.key,
                amount:entry.value,
                percentageOfTotal: maxSpending==0.0
                    ? 0.0
                    :  entry.value/maxSpending,
              ),
            );
          }).toList(),
      ),
      ),


    );
  }
}
