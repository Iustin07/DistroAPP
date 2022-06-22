import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/centralizer.dart';
import '../../widgets/simple_app_bat.dart';
import '../../providers/centralizers_provider.dart';
import '../handler_screens/centralzier_card.dart';
class GenerateCentralizersScreen extends StatelessWidget {
  const GenerateCentralizersScreen({Key? key}) : super(key: key);
static const routeName='/generate';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Generate Centralizers'),
      body:const GenerateBody(),
    );
  }
}

class GenerateBody extends StatefulWidget {
  const GenerateBody({Key? key}) : super(key: key);

  @override
  State<GenerateBody> createState() => _GenerateBodyState();
}

class _GenerateBodyState extends State<GenerateBody> {
    DateTime? _selectedDate;
    bool _loading=false;
    List<Centralizer> _centralizers=[];
     String? date;
     bool _init=true;
    @override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _loading=true;
      });
       String todaydate=DateTime.now().toString().split(" ")[0];
           Provider.of<Centralizers>(context,listen: false).fetchByDateCentralizers(todaydate).then((value){
                      setState(() {
                       _centralizers=List.from(value); 
                       _loading=false;
                      });
                    });
    }
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(children: <Widget>[
         Container(
          
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin:const  EdgeInsets.only(left: 30, right: 30),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                  ),
                ),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Choose Date',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Container(
            margin: const EdgeInsets.only(left: 10,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if(_centralizers.isEmpty){
                       setState(() {
                        _loading=true;
                   date=DateFormat('yyyy-MM-dd').format(_selectedDate as DateTime);        
                });
                  Provider.of<Centralizers>(context, listen: false).generateCentralizers(date as String).then((value){
                  if(value==200){
                      ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        'Centralizers was succesfuly created',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                 String todaydate=DateTime.now().toString().split(" ")[0];
                    Provider.of<Centralizers>(context,listen: false).fetchByDateCentralizers(todaydate).then((value){
                      setState(() {
                       _centralizers=List.from(value); 
                       _loading=false;
                      });
                    });
                   
                
                  }else{
                    setState(() {
                      _loading=false;
                      _centralizers=[];
                    });
                  }
                 });
                  }else{
                    showDialog(context: context, builder: (ctx)=>
                   AlertDialog(
                    title: const Text(''),
                content: const Text('For today was generated centralizers already'),
                actions: <Widget>[
                  TextButton(
                    child:const Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
                   )
                    
            
                    );
                  }
                  
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromRGBO(192, 57, 43, 1.0)),),
                  child: const Text('Generate'),
                ),
              ],
            ),
          ),
          _loading
            ? const CircularProgressIndicator()
            : Expanded(
                child: _centralizers.isEmpty
                    ? const Center(
                        child: Text('There are no centralizers/orders  on this date'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: _centralizers.length,
                            itemBuilder: (ctx, index) => CentralizerCard(
                                  key: ValueKey(_centralizers[index]
                                      .centralizerId
                                      .toString()),
                                  centralizerId:
                                      _centralizers[index].centralizerId,
                                  driverName: _centralizers[index].driverName,
                                  date: _centralizers[index].date,
                                  value: _centralizers[index]
                                      .calculatedValuesforValueAndWeight
                                      .orderPaymentValue as double,
                                  weight: _centralizers[index]
                                      .calculatedValuesforValueAndWeight
                                      .totalWeight as double,
                                )),
                      ))
      ]),
    );
  }
  
    void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}


