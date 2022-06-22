import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './chart_bar.dart';
import '../../providers/stats_provider.dart';
class Chart extends StatefulWidget {

  Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
Map<String,double> _stats={};
bool _loading=false;
bool _init=true;
double? maxSpending;
@override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _loading=true;
      });
 Provider.of<Stats>(context,listen: false).getMonthlyStat().then((value) {
   setState(() {
     _loading=false;
     _stats=Provider.of<Stats>(context,listen: false).getMonthlyStats;
     maxSpending=Provider.of<Stats>(context,listen: false).maxSpending;
   });
 });
    }
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return _loading? const CircularProgressIndicator():Card(
      elevation: 6,
      child: Padding(padding: const EdgeInsets.all(5),
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
                    :  entry.value/maxSpending!,
              ),
            );
          }).toList(),
      ),
      ),


    );
  }
}
