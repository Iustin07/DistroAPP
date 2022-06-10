import '../widgets/simple_app_bat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart.dart' show Cart;
import '../widgets/orders/cart_item_widget.dart' show CartItem;
import '../providers/clients.dart';
import '../providers/orders_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Map<int, String>? clientsList;
  bool _loading = false;
  Cart? cart;
  bool _init = true;
  int? _clientId = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _loading = true;
      });

      Provider.of<Clients>(context, listen: false).getClients().then((value) {
        setState(() {
          clientsList = Map.from(value);
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: SimpleAppBar(title: 'Order'),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 15, left: 50, right: 15),
                    child: Row(
                      children: [
                        const Text(
                          'Client: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SingleChildScrollView(
                          child: DropdownButton<String>(
                            hint: const Text('Select client'),
                            menuMaxHeight: 300,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 16),
                            focusColor: Colors.white60,
                            dropdownColor:
                                const Color.fromARGB(255, 30, 161, 217),
                            items: clientsList!.isEmpty
                                ? [
                                    DropdownMenuItem(
                                        child: Text("Sunt prost"),
                                        value: "foarte prost"),
                                  ]
                                : clientsList!.entries.map((e) {
                                    return DropdownMenuItem(
                                        value: e.key.toString(),
                                        child: Text(
                                          '${e.value}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ));
                                  }).toList(),
                            value: _clientId.toString(),
                            onChanged: (item) => setState(() {
                              print(item);
                              _clientId = int.tryParse(item as String);
                            }),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Total',
                                style: TextStyle(fontSize: 14),
                              ),
                              const Spacer(),
                              Chip(
                                label: Text(
                                  '${cart!.totalAmount.toStringAsFixed(2)} RON',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color,
                                  ),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              TextButton(
                                child: const Text('Save order'),
                                onPressed: () {
                                  setState(() {
                                    _loading = true;
                                  });
                                  Provider.of<Orders>(context, listen: false)
                                      .addOrder(
                                    cart!.items.values,
                                    cart!.totalAmount,
                                    cart!.totalWeight,
                                    _clientId as int,
                                  )
                                      .then((value) {
                                    setState(() {
                                      _loading = false;
                                      cart!.clear();
                                    });
                                    // Navigator.of(context).pop();
                                  });
                                },
                              )
                            ],
                          ),
                          const Divider(
                            color: Colors.black87,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              const Text(
                                'Total weight',
                                style: TextStyle(fontSize: 14),
                              ),
                              const Spacer(),
                              Chip(
                                label: Text(
                                  '${cart!.totalWeight.toStringAsFixed(2)} kg',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .color,
                                    //color: Theme.of(context).primaryTextTheme.title.color,
                                  ),
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart!.items.length,
                      itemBuilder: (ctx, i) => CartItem(
                        cart!.items.keys.toList()[i],
                        cart!.items.values.toList()[i].productId,
                        cart!.items.values.toList()[i].title,
                        cart!.items.values.toList()[i].price,
                        cart!.items.values.toList()[i].quantity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
