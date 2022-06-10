import 'package:distroapp/model/custom_employe.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/order.dart';
import '../../screens/agent_screens/order_card.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';
import '../../providers/users.dart';
class OrdersMainWidget extends StatefulWidget {
  OrdersMainWidget({Key? key, required BuildContext context}) : super(key: key);
  BuildContext? context;
  @override
  State<OrdersMainWidget> createState() => _OrdersMainWidgetState();
}

class _OrdersMainWidgetState extends State<OrdersMainWidget> {
  CustomEmployee? agentName;
  List<CustomEmployee>? agents;
  DateTime? _selectedDate;
  List<Order> _orders = [];
  bool _init=true;
  bool _loading=false;
  @override
  void didChangeDependencies() {
     if (_init) {
      setState(() {
        _loading = true;
      });

      Provider.of<Users>(context, listen: false).getSpecificRequest('agent').then((value) {
        setState(() {
        agents = List.from(value);
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _orders.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.blue[200],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              const Text('Select agent',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),),
              const SizedBox(
                width: 10,
              ),
            _loading? CircularProgressIndicator() :DropdownButton<CustomEmployee>(
                menuMaxHeight: 300,
                hint: const Text('agent'),
                value: agentName,
                icon: const Icon(Icons.keyboard_arrow_down),
                items:agents!.map<DropdownMenuItem<CustomEmployee>>((CustomEmployee agent){
                  return DropdownMenuItem<CustomEmployee>(
                  value: agent,
                  child: Text(agent.name as String, ),);
                } ,).toList(),
                onChanged: (newValue) {
                  setState(() {
                    agentName = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue[300],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(left: 30, right: 30),
          height: 70,
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
        Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  String date=DateFormat('yyyy-MM-dd').format(_selectedDate as DateTime);
                  Provider.of<Orders>(context, listen: false).fetchOrderOfAgent(agentName!.employeeId as int,date );
                  _orders = Provider.of<Orders>(context,listen: false).orders;
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor)),
              child: const Text('Show orders'),
            ),
          ],
        ),
        displayList(),
      ],
    );
  }

  Widget displayList() {
    return Expanded(
      child: _orders.isEmpty
          ? Container(
              child:  const Text('There are is no request yet'),
            )
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (ctx, index) => OrderCard(
                order: _orders[index],
                color: Colors.blue[400] as Color,
              ),
            ),
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
