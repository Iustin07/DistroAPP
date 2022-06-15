import '../../model/custom_centralizer.dart';
import './order_check_card.dart';
import 'package:flutter/material.dart';
import '../../model/order.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providers/orders_provider.dart';
import '../agent_screens/order_card.dart';
import '../../model/custom_employe.dart';
import '../../providers/users.dart';
class CentralizerMainWidget extends StatefulWidget {
  CentralizerMainWidget({Key? key, required this.context}) : super(key: key);
  BuildContext context;
  @override
  State<CentralizerMainWidget> createState() => _CentralizerMainWidgetState();
}

class _CentralizerMainWidgetState extends State<CentralizerMainWidget> {
   CustomEmployee? agentName;
  CustomEmployee? driverName;
  DateTime? _selectedDate;
  List<Order> _orders = [];
  CustomCentralizer? cart;
  List<CustomEmployee>? agents;
    List<CustomEmployee>? drivers;
    Orders? orderProvider;
  bool _init=true;
  bool _loading=false;
  @override
  void dispose() {

    super.dispose();
  }
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _loading = true;
      });
      Provider.of<Users>(context, listen: false).getSpecificRequest('agent').then((value) {
        setState(() {
        agents = List.from(value);
        });  
      });
      Provider.of<Users>(context, listen: false).getSpecificRequest('driver').then((value) {
        setState(() {
        drivers = List.from(value);
          _loading = false;
        });});
    }
    _init = false;
    setState(() {
      cart = Provider.of<CustomCentralizer>(context);
      orderProvider = Provider.of<Orders>(context);
    });
      
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    

  return   Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color:const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Select agent',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<CustomEmployee>(
                menuMaxHeight: 300,
                hint: const Text('agent'),
                value: agentName,
                icon: const Icon(Icons.keyboard_arrow_down),
                items:agents?.map<DropdownMenuItem<CustomEmployee>>((CustomEmployee agent){
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
                color: const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin:const  EdgeInsets.only(left: 30, right: 30),
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
                  child: Text(
                    'Choose Date',
                    style:const  TextStyle(
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
                  String date=DateFormat('yyyy-MM-dd').format(_selectedDate as DateTime);
                  Provider.of<Orders>(context, listen: false).fetchOrderOfAgent(agentName!.employeeId as int,date );
                _orders=orderProvider!.orders;
                });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                         const Color.fromRGBO(192, 57, 43, 1.0)),),
                  child: const Text('Show orders'),
                ),
              ],
            ),
          ),
          selectdriver(cart as CustomCentralizer),
          displayList(),
        ],
      );
  }

  Widget selectdriver(CustomCentralizer cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
           color: const Color.fromARGB(255, 214, 104, 83),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(25),
        ),
        height: 70,
        child: Column(
          children: <Widget>[
 const  Text(
          'Select driver',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
     
        DropdownButton<CustomEmployee>(
                menuMaxHeight: 300,
                hint: const Text('driver'),
                value: driverName,
                icon: const Icon(Icons.keyboard_arrow_down),
                items:drivers?.map<DropdownMenuItem<CustomEmployee>>((CustomEmployee driver){
                  return DropdownMenuItem<CustomEmployee>(
                  value: driver,
                  child: Text(driver.name as String, style: const TextStyle(fontWeight: FontWeight.w700),),);
                } ,).toList(),
                onChanged: (newValue) {
                  setState(() {
                    driverName = newValue!;
                    cart.driverId=driverName!.employeeId!;
                  });
                },
              ),
          ],
        ),
      ),
     
        TextButton(
          style: ButtonStyle(elevation: MaterialStateProperty.all<double>(5.0),
           backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(192, 57, 43, 1.0)),),
          
          onPressed: (){}, child: Text('${cart.totalAmount.toStringAsFixed(2)} RON', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),),
               TextButton(
          style: ButtonStyle(elevation: MaterialStateProperty.all<double>(5.0),
           backgroundColor: MaterialStateProperty.all<Color>(
                         const  Color.fromRGBO(192, 57, 43, 1.0)),),
          
          onPressed: (){}, child: Text('${cart.totalWeight.toStringAsFixed(2)} kg', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),),
        
      ],
    );
  }
 Widget displayList() {
    return Expanded(child:
       _orders.isEmpty
          ? Center(
              child:  const Text('There are is no request yet'),
            )
          :  Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                  itemCount: _orders.length,
                  itemBuilder: (ctx, index) => OrderCheckedCard(
                                   key: ValueKey(_orders[index].orderId),
                                   orderId: _orders[index].orderId!,
                                   clientName: _orders[index].client!.clientName as String,
                                   paymentValue: _orders[index].orderPaymentValue!,
                                   totalWeight: _orders[index].totalWeight!,
                                 )
                ),
          ),
          
    );
    
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
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
