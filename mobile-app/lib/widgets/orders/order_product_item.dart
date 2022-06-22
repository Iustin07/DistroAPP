import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/cart.dart' show Cart;
import '../../../../model/product.dart' show Product;

class OrderProductItem extends StatefulWidget {
  const OrderProductItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<OrderProductItem> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  final _quantityController = TextEditingController();
  double? _stock;
  String? quantity = '0';
  @override
  void initState() {
    _stock = widget.product.stock;
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);

    return Card(
      color: const Color.fromARGB(255, 224, 224, 224),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Row(children: <Widget>[
        Container(
          width: 40,
          margin:const EdgeInsets.only(left: 3),
          child: Text(
            '${widget.product.productId}',
            softWrap: true,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(left: 8, right: 3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        maxLines: 1,
                        widget.product.productName,
                        style:const  TextStyle(fontSize: 16)),
                    Row(
                      children: <Widget>[
                        //Text('Stock: ${product.stock}'),
                        Text('Price:${widget.product.priceChoice} RON'),
                       const SizedBox(width: 5, ),
                        Text(widget.product.unitMeasure),
                     const   SizedBox(width: 5,),
                        Text(widget.product.category),                   
                      ],
                    )
                  ]),
            )),
        Row(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: 70,
              height: 30,
              child: TextField(    
                controller: _quantityController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if(value.isEmpty){
                      _quantityController.text='0';
                    }
                    _quantityController.value = TextEditingValue(
                      text: value,
                      selection: TextSelection.collapsed(offset: value.length),
                    );
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  labelText: 'Quantity',
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  if(double.tryParse(_quantityController.text)!<0){
                    alertMessage(context, 'Quantity', 'Please provide a positive value');
                  }else
                  if (double.parse(_quantityController.text) > _stock!) {
                      alertMessage(context,'Stock Alert','There is not enough quntity tu fullfil this request');
                  } else {
                    cart.addItem(
                      widget.product.productId,
                      widget.product.productName,
                      widget.product.priceChoice,
                      int.parse(_quantityController.text),
                      widget.product.weight,
                    );
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Added item to order!', ),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeItem(widget.product.productId);
                          },
                        ),
                      ),
                    );
                    setState(() {
                      _quantityController.text='';
                    });
                  }
                },
                icon:const Icon(Icons.add)),
          ],
        )
      ]),
    );
  }

   alertMessage(BuildContext context, String titleText ,String message) {
    return showDialog(
      context: context,
      builder: (context){
      return
    AlertDialog(
      title:  Text(titleText),
      content: SingleChildScrollView(
        child: ListBody(
          children:  <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            setState(() {
              _quantityController.text = '';
            });
            Navigator.of(context).pop();
          },
        ),
      ],
                          );
                          }
    );
  }
}
