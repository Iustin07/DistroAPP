import 'package:provider/provider.dart';

import '../../../model/product.dart';
import 'package:flutter/material.dart';
import '../../../providers/products.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);
 static const routeName='/add-product';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}
class _AddProductScreenState extends State<AddProductScreen> {
  final _priceUnitFocusNode = FocusNode();
  final _priceBoxFocusNode = FocusNode();
  final _pricePalletFocusNode = FocusNode();
  final _palletUnitsFocuNode = FocusNode();
  final _boxUnitsFocuNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _producerFocusNode = FocusNode();
  final _unitFocusNode = FocusNode();
  final _weightFocuNode = FocusNode();
  final _stockFocuNode = FocusNode();
  final _screenFocus=FocusNode();
  final _form = GlobalKey<FormState>();
  String? unit = 'Buc';
  String? categoryChosen='Drink';
    var _newProduct = ProductBuilder(-1)
    ..productName=''
    ..producer=''
    ..category='Drink'
    ..pricePerBox=0.0
    ..pricePerPallet=0.0
    ..pricePerUnit=0.0
    ..unitMeasure='Buc'
    ..stock=0.0
    ..weight=0.0;
  bool _loading=false;
  @override
  void dispose() {
    _screenFocus.dispose();
    _nameFocusNode.dispose();
    _producerFocusNode.dispose();
    _priceUnitFocusNode.dispose();
    _priceBoxFocusNode.dispose();
    _pricePalletFocusNode.dispose();
    _unitFocusNode.dispose();
    _boxUnitsFocuNode.dispose();
    _palletUnitsFocuNode.dispose();
    _weightFocuNode.dispose();
    _stockFocuNode.dispose();
    unit=null;
    categoryChosen=null;
  
    super.dispose();
  }
  Future<void> _saveForm() async{
    //validari
   _form.currentState!.save();
   setState(() {
     _loading=true;
   });
   try {
        await Provider.of<Products>(context, listen: false)
            .addProduct((_newProduct).build());
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurred!'),
                content: Text('Something went wrong.'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okay'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ),
        );
      }
      setState(() {
        _loading=false;
      });
      Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add product')),
      body:_loading?
      Center(child: CircularProgressIndicator(),)
      : Container(
        padding: EdgeInsets.all(8.0),
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
                    getTTExtFormField(context,'Product Name',_nameFocusNode,(value){_newProduct.productName=value;
                    print(value);
                    }),
                    SizedBox(height: 5,),
                    getTTExtFormField(context,'Producer',_producerFocusNode,(value){_newProduct.producer=value;}),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text('Unit measure',style: TextStyle(color: Colors.white70,fontSize: 16),),
                        SizedBox(
                          width: 7,
                        ),
                        DropdownButton<String>(
                          style:TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor: Color.fromARGB(255,30, 161, 217),
                          items: <String>['Buc', 'Box', 'But','Nav'].map((value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          value: unit,
                          onChanged: (item) => setState(() {
                            unit = item;
                            _newProduct.unitMeasure=unit as String;
                          }),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                  getTextNumberTextField(context,'Price per unit',_priceUnitFocusNode,(value){_newProduct.pricePerUnit=double.parse(value);}),
                  SizedBox(height: 7,),
                  getTextNumberTextField(context,'Price per box',_priceBoxFocusNode,(value){_newProduct.pricePerBox=double.parse(value);}),
                  SizedBox(height: 7,),
                  getTextNumberTextField(context,'Price per pallet',_pricePalletFocusNode,(value){_newProduct.pricePerPallet=double.parse(value);}),
                  SizedBox(height: 7,),
                  getTextNumberTextField(context,'Units per box',_boxUnitsFocuNode,(value){_newProduct.unitsPerBox=int.parse(value);}),
                  SizedBox(height: 7,),
                  getTextNumberTextField(context,'Units per pallet',_palletUnitsFocuNode,(value){_newProduct.unitsPerPallet=int.parse(value);}),
                  Row(
                      children: <Widget>[
                        Text('Category',style: TextStyle(color: Colors.white70,fontSize: 16),),
                        SizedBox(
                          width: 7,
                        ),
                        DropdownButton<String>(
                          style:TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor: Color.fromARGB(255,30, 161, 217),
                          items: <String>['Drink', 'Chips', 'Coffee'].map((value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          value: categoryChosen,
                          onChanged: (item) => setState(() {
                            categoryChosen = item;
                            _newProduct.category=categoryChosen as String;
                          }),
                          icon: Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                  getTextNumberTextField(context,'stock',_stockFocuNode,(value){_newProduct.stock=double.parse(value);}),
                    SizedBox(height: 5,),
                  getTextNumberTextField(context,'weight',_weightFocuNode,(value){_newProduct.weight=double.parse(value);}),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('Cancel')),
                        ElevatedButton(onPressed: () {_saveForm();}, child: Text('Save')),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField getTextNumberTextField(BuildContext context,String? title,FocusNode focus,Function saveHandler) {
    return TextFormField(
                decoration:  InputDecoration(
                  fillColor: const Color.fromARGB(255, 30, 161, 217),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: title,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black45, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: const BorderSide(
                          color: Colors.cyanAccent, width: 2.0)),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: focus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus();
                },
                onSaved: (value){saveHandler(value);},
              );
  }

  TextFormField getTTExtFormField(BuildContext context,String? text,FocusNode focus,Function savedHandler) {
    return TextFormField(
      style: TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
                decoration:  InputDecoration(
                  fillColor: Color.fromARGB(255, 30, 161, 217),
                  filled: true,
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: text,
                  enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black45, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: const BorderSide(
                          color: Colors.cyanAccent, width: 2.0)),
                ),
                focusNode: focus,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus();
                },
                textInputAction: TextInputAction.next,
                onSaved:  (value){savedHandler(value);},
              );
  }
}
