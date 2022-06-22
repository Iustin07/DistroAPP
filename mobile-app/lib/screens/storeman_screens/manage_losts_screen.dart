import 'package:distroapp/model/product.dart';
import 'package:distroapp/providers/products.dart';
import 'package:flutter/material.dart';
import '../../providers/losts.dart';
import 'package:provider/provider.dart';
import '../../model/lost.dart';

class ManageLostsScreen extends StatelessWidget {
  const ManageLostsScreen({Key? key}) : super(key: key);

  static const routeName = '/losts';

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
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddDialog();
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ShowLostsList(),
    );
  }
}

class ShowLostsList extends StatefulWidget {
  ShowLostsList({Key? key}) : super(key: key);

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
    Provider.of<Losts>(context).fetchLostsRequestedUser().then((value) {
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
            child: Text('no losts this month'),
          )
        : ListView.builder(
            itemCount: _losts.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:const BorderSide(color: Colors.black),
          ),
                    tileColor: Colors.purple,
                    title: Text(_losts[index].product!.productName),
                    trailing: Text('${_losts[index].quantity.toString()} ${_losts[index].product!.unitMeasure}'),
                    subtitle: Text(_losts[index].dateOfLost.toString()),
                  ),
                ));
  }
}

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  bool _init = true;
  bool _loading = false;
  List<Product> _products = [];
  @override
  void didChangeDependencies() {
    if(_init){
      setState(() {
        _loading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts();
      setState(() {
         _products = Provider.of<Products>(context,listen: false).products;
        _loading = false;
      });
    }
    _init=false;
    super.didChangeDependencies();
  }

  final _formLost = GlobalKey<FormState>();
  Product? dropdownValue;
  double? quantity;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title:const Text('Add lost'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formLost,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Text('Choose product'),
                 const SizedBox( width: 10, ),
                  _loading
                      ? const CircularProgressIndicator()
                      : DropdownButton<Product>(
                          menuMaxHeight: 300,
                          hint: const Text('product'),
                          value: dropdownValue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: _products.map<DropdownMenuItem<Product>>(
                            (Product product) {
                              return DropdownMenuItem<Product>(
                                value: product,
                                child: SizedBox(
                                    width: 100,
                                    child: Text(product.productName)),
                              );
                            },
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                        ),
                ],
              ),
              TextFormField(
                decoration:const InputDecoration(
                  labelText: 'quantity',
                  icon: Icon(Icons.add_moderator),
                ),
                onSaved: (value) {
                  quantity = double.parse(value as String);
                },
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            child: const Text("Add"),
            onPressed: () {
              _saveLost();
            })
      ],
    );
  }

  void _saveLost() {
    _formLost.currentState!.save();
    Provider.of<Losts>(context, listen: false)
        .addLost(dropdownValue!.productId, quantity as double)
        .then((value) {
      if (value == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>const ManageLostsScreen(),
            ),
            ModalRoute.withName('/'));
      }
      
    });
  }
}
