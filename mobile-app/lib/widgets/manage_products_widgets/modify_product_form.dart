import 'package:distroapp/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/product.dart';
import '../../../providers/products.dart';

class ModifyProductForm extends StatefulWidget {
  ModifyProductForm({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<ModifyProductForm> createState() => _ModifyProductFormState();
}

class _ModifyProductFormState extends State<ModifyProductForm> {
  final _form = GlobalKey<FormState>();
  ProductBuilder? _editedProduct;
  String? unit;
  bool _loading = false;
  final _screenFocus = FocusNode();
  @override
  void dispose() {
    _screenFocus.dispose();
    _editedProduct = null;
    unit = null;
    super.dispose();
  }

  var _isInit = true;
  @override
  void initState() {
    unit = widget.product.unitMeasure;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedProduct = ProductBuilder.convertProductToBuilder(widget.product);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveProduct(int id, ProductBuilder product) async {
    //validations
    _form.currentState!.save();
    setState(() {
      _loading = true;
    });
    try {
      await Provider.of<Products>(context, listen: false)
          .modifyProduct(id, product.build());
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title:const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child:const  Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _loading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Theme.of(context).primaryColor,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(_screenFocus),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: <Widget>[
                        showTextFormField(
                            'Product name', widget.product.productName,
                            (value) {
                          if (_editedProduct!.productName != value){
                            _editedProduct!.productName = value;}
                        }),
                        showTextFormField('Producer', widget.product.producer,
                            (value) {
                          if (_editedProduct!.producer != value){
                            _editedProduct!.producer = value;}
                        }),
                        Row(
                          children: <Widget>[
                            const Text(
                              'Unit measure',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            DropdownButton<String>(
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 16),
                              focusColor: Colors.white60,
                              dropdownColor:const  Color.fromARGB(255, 30, 161, 217),
                              items: <String>['Buc', 'Box', 'Pal']
                                  .map((value) {
                                return DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              value: unit,
                              onChanged: (item) => setState(() {
                                unit = item;
                                _editedProduct!.unitMeasure = unit as String;
                              }),
                              icon: const Icon(Icons.arrow_drop_down_circle),
                            ),
                          ],
                        ),
                        showNumberFormField('Price per unit',
                            widget.product.pricePerUnit.toString(), (value) {
                          _editedProduct!.pricePerUnit = double.parse(value);
                        }),
                        showNumberFormField('Price per box',
                            widget.product.pricePerBox.toString(), (value) {
                          _editedProduct!.pricePerBox = double.parse(value);
                        }),
                        showNumberFormField('Price per pallet',
                            widget.product.pricePerPallet.toString(), (value) {
                          _editedProduct!.pricePerPallet = double.parse(value);
                        }),
                        showNumberFormField('Units per box',
                            widget.product.unitsPerBox.toString(), (value) {
                          _editedProduct!.unitsPerBox = int.parse(value);
                        }),
                        showNumberFormField('Units per pallet',
                            widget.product.unitsPerPallet.toString(), (value) {
                          _editedProduct!.unitsPerPallet = int.parse(value);
                        }),
                        showTextFormField('Category', widget.product.category,
                            (value) {
                          _editedProduct!.category = value;
                        }),
                        showNumberFormField(
                            'Stock', widget.product.stock.toString(), (value) {
                          _editedProduct!.stock = double.parse(value);
                        }),
                        showNumberFormField(
                            'Weight', widget.product.weight.toString(),
                            (value) {
                          _editedProduct!.weight = double.parse(value);
                        }),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  _saveProduct(widget.product.productId,
                                      _editedProduct as ProductBuilder);
                                },
                                child: const Text('Save')),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  TextFormField showNumberFormField(
    String title,
    String initialValue,
    Function saveHandler,
  ) {
    return TextFormField(
      style: const TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
      initialValue: initialValue,
      decoration: InputDecoration(
        fillColor: const Color.fromARGB(255, 30, 161, 217),
        filled: true,
        labelStyle: const TextStyle(color: Colors.white),
        labelText: title,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black45, width: 2.0),
        ),
        focusedBorder:const  OutlineInputBorder(
            borderRadius:  BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.cyanAccent, width: 2.0)),
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value){
        return Validator.validateDouble(value);
      },
      onSaved: (value) => saveHandler(value),
    );
  }

  TextFormField showTextFormField(
      String title, String initialValue, Function saveHandler) {
    return TextFormField(
        style: const TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
        initialValue: initialValue,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 30, 161, 217),
          filled: true,
          labelStyle:const TextStyle(color: Colors.white),
          labelText: title,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black45, width: 2.0),
          ),
          focusedBorder:const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.cyanAccent, width: 2.0)),
        ),
        textInputAction: TextInputAction.next,
        validator: (value)=>Validator.validateDouble(value),
        onSaved: (value) => saveHandler(value));
  }
}
