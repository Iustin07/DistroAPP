import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'chart.dart';
import '../../screens/manager_screens.dart/repair_card.dart';
import '../../screens/manager_screens.dart/top_products.dart';
import './repair_card.dart';
import '../../providers/users.dart';
import '../../providers/orders_provider.dart';
class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);
  static const routeName = "/stats";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Stats'),
      ),
      body:
         SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
            children: <Widget>[
                   Card(
             child:Column(children: [
               const Text('Monthly income',
               style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
               Chart(),
             ]) ,
                   ),
              
              const RepairCard(),
              const Card(child: Text('Most selled products this month',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),),
             const  TopProductsList(),
             BottomStats(),
            ],
                  ),
          )),
    
    );
  }


}
class BottomStats extends StatefulWidget {
  BottomStats({Key? key}) : super(key: key);

  @override
  State<BottomStats> createState() => _BottomStatsState();
}

class _BottomStatsState extends State<BottomStats> {
  bool _init=true;
  bool _isLoading=false;
  bool _receiveWage=false;
  bool _receiveIncome=false;
  double? wages;
  double? income;
  @override
  void didChangeDependencies() async {
    if(_init){
      setState(() {
        _isLoading=true;
      });
       Provider.of<Users>(context).getWages().then((value)  {
        setState(() {
          wages=value;
          _receiveWage=true;
        });
      });
      Provider.of<Orders>(context).getIncome().then((value){
        setState(() {
          income=value;
          _isLoading=false;
        });
      });
        
    }
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  _isLoading? const Center(child:CircularProgressIndicator())
    :Row(
              children: <Widget>[
               
                  Stack(
                    children: [
                      ConstrainedBox(
                        constraints:const BoxConstraints(maxHeight: 200,maxWidth: 200),
                        
                      child: Container(
                        margin:const EdgeInsets.only(left: 5),
                        color:  Colors.greenAccent,
                        child:     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        
                        const Text('Wages this month:',
                        style: TextStyle(fontWeight: FontWeight.w600),),
                        Image.asset('assets/images/wages.png',height: 100,width: 200,),
                        
                        Text('${wages==null? 0:wages}',style:const TextStyle(fontWeight: FontWeight.w600),)
                      ],),
                        ),
                      ),
                  
                    ],
                  ),
                 Stack(
                    children: [
                      ConstrainedBox(
                        constraints:const  BoxConstraints(maxHeight: 200,maxWidth: 200),
                        
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        color:  Colors.green[100],
                        child:     Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        
                       const  Text('Products bought:',
                        style: TextStyle(fontWeight: FontWeight.w600),),
                        Image.asset('assets/images/truck.png',height: 100,width: 200,),
                        
                        Text('${income!.toStringAsFixed(2)}',style: const TextStyle(fontWeight: FontWeight.w600),)
                      ],),
                        ),
                      ),
                  
                    ],
                  ),
  
              ],
            );
  }
}