import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../../model/lost.dart';
import 'package:provider/provider.dart';
import '../../providers/losts.dart';
class ManageLostsManagerScreen extends StatelessWidget {
  const ManageLostsManagerScreen({Key? key}) : super(key: key);
  static const routeName = "/manager-losts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Manage losts'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: LostsMainWidget(),
    );
    ;
  }
}

class LostsMainWidget extends StatefulWidget {
  LostsMainWidget({Key? key}) : super(key: key);

  @override
  State<LostsMainWidget> createState() => _LostsMainWidgetState();
}

class _LostsMainWidgetState extends State<LostsMainWidget> {
  DateTime? _firstDate;
  DateTime? _secondDate;
  bool _showList=true;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
      child: Column(
        children: <Widget>[
          const Text('Select period'),
          GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  shrinkWrap: true,
  children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(left: 30, right: 30),
            height: 50,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _firstDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_firstDate as DateTime)}',
                  ),
                ),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                        showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return ;
        }
        setState(() {
          _firstDate=pickedDate;
        });
      });
                  }
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 214, 104, 83),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.only(left: 30, right: 30),
            height: 50,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _secondDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_secondDate as DateTime)}',
                  ),
                ),
                TextButton(
                  child: Text(
                    'Choose Date',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed:(){
                        showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return ;
        }
        setState(() {
          _secondDate=pickedDate;
        });
      });
                  }
                  
                ),
              ],
            ),
          ),]
          ),
          ElevatedButton(onPressed: () {
            print('show called');
              setState(() {
                if(_firstDate!=null && _secondDate!=null)
                _showList=false;
              });
          }, child: Text('Show')),
          _showList? Container():ShowLostsList(firstDate: _firstDate.toString().split(" ")[0], secondDate: _secondDate.toString().split(" ")[0])
        ],
      ),
    );
  }

}

class ShowLostsList extends StatefulWidget {
  ShowLostsList({Key? key,
  required this.firstDate,
  required this.secondDate}) : super(key: key);
  String firstDate;
  String secondDate;
  @override
  State<ShowLostsList> createState() => _ShowLostsListState();
}

class _ShowLostsListState extends State<ShowLostsList> {
  bool _isLoading = false;
  List<Lost> _losts = [];
  @override
  void didChangeDependencies() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Losts>(context).fetchLostsBySpecifiedPeriod(widget.firstDate, widget.secondDate).then((value) {
      setState(() {
        _isLoading = false;
        _losts = List.from(value);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _losts.isEmpty
        ? const Center(
            child: Text('no losts during this period'),
          )
        : 
          Expanded(
            child: ListView.builder(
                itemCount: _losts.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.purple,
                        title: Text(_losts[index].product!.productName),
                        trailing: Text(_losts[index].quantity.toString()),
                        subtitle: Text(_losts[index].dateOfLost.toString()),
                      ),
                    ),
                  ),
          );
  }
}
