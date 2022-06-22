import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import './centralzier_card.dart';
import '../../model/centralizer.dart';
import '../../providers/centralizers_provider.dart';

class CentralizersList extends StatefulWidget {
  const CentralizersList({Key? key}) : super(key: key);

  @override
  State<CentralizersList> createState() => _CentralizersListState();
}

class _CentralizersListState extends State<CentralizersList> {
  List<Centralizer>? centralizers=[];
  DateTime? _selectedDate;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 192, 192, 192),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(left: 30, right: 30),
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
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    String date = DateFormat('yyyy-MM-dd')
                        .format(_selectedDate as DateTime);
                    setState(() {
                      _isLoading = true;
                    });
                    Provider.of<Centralizers>(context,listen: false)
                        .fetchByDateCentralizers(date)
                        .then((value) {
                      setState(() {
                        centralizers = List.from(value);
                        _isLoading = false;
                      });
                    });
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(192, 192, 192, 0.7)),
                ),
                child: const Text('Show'),
              ),
            ],
          ),
        ),
        _isLoading
            ? const CircularProgressIndicator()
            : Expanded(
                child: centralizers!.isEmpty
                    ? const Center(
                        child: Text('There are no centralizers on this date'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: centralizers!.length,
                            itemBuilder: (ctx, index) => CentralizerCard(
                                  key: ValueKey(centralizers![index]
                                      .centralizerId
                                      .toString()),
                                  centralizerId:
                                      centralizers![index].centralizerId,
                                  driverName: centralizers![index].driverName,
                                  date: centralizers![index].date,
                                  value: centralizers![index]
                                      .calculatedValuesforValueAndWeight
                                      .orderPaymentValue as double,
                                  weight: centralizers![index]
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
      firstDate: DateTime(2022),
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
