import 'package:distroapp/screens/driver_screens/centralizerdetailscreen.dart';

import '../../providers/centralizers_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/centralizer.dart';
class ShowCentralizersWidget extends StatefulWidget {
  ShowCentralizersWidget({Key? key}) : super(key: key);

  @override
  State<ShowCentralizersWidget> createState() => _ShowCentralizersWidgetState();
}

class _ShowCentralizersWidgetState extends State<ShowCentralizersWidget> {
  DateTime? _selectedDate;
  bool _loading=false;
  List<Centralizer> _centralizers=[];
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin:const  EdgeInsets.only(left: 30, right: 30,top: 20),
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                ),
                TextButton(
                  child: const Text(
                    'Choose Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                       setState(() {
                         _loading=true;
                  String date=DateFormat('yyyy-MM-dd').format(_selectedDate as DateTime);
                 Provider.of<Centralizers>(context, listen: false).fetchCentralizersByDateAndDriver(date).then((value){
                   _centralizers=List.from(value);
                   _loading=false;
                 });
                
                });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromRGBO(192, 57, 43, 1.0)),),
                  child: const Text('Show'),
                ),
              ],
            ),
          ),
          displayList(),
        ],
      );
  }
    Widget displayList() {
    return Expanded(
      child: _centralizers.isEmpty
          ? Container(
              child:  const Text('Provide a date in order to see your centralizers for today',
              softWrap: true,),
            )
          : ListView.builder(
              itemCount: _centralizers.length,
              itemBuilder: (ctx, index) => CentralizerCard(
                centralizer: _centralizers[index],
              ),
            ),
    );
  }
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 7)),
      firstDate: DateTime.now().subtract(Duration(days: 7)),
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
class CentralizerCard extends StatelessWidget {
   CentralizerCard({Key? key,required this.centralizer}) : super(key: key);
  Centralizer centralizer;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.lime,
      child: InkWell(
        onTap: ()=>Navigator.of(context).pushNamed(CentralizerDetailsScreen.routeName, arguments: centralizer.centralizerId),
        child: Row(
          children: [
            Text(centralizer.centralizerId.toString()),
            const SizedBox(width: 15,),
            Text(centralizer.driverName),
          ],
        ),
      ),
    );
  }}
