import '../../utils/validation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../model/product.dart';
import '../../../providers/products.dart';
class AddProductScreen extends StatefulWidget {
 const AddProductScreen({Key? key}) : super(key: key);
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
   if(!_form.currentState!.validate()){
     return;
   }
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
                title: const Text('An error occurred!'),
                content:const  Text('Something went wrong.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Okay'),
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
      appBar: AppBar(title:const  Text('Add product')),
      body:_loading?
      const Center(child: CircularProgressIndicator(),)
      : Container(
        padding: const EdgeInsets.all(8.0),
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
                    getTTExtFormField(context,'Product Name',_nameFocusNode,(value){_newProduct.productName=value;}),                  
                    getTTExtFormField(context,'Producer',_producerFocusNode,(value){_newProduct.producer=value;}),
                    Row(
                      children: <Widget>[
                        const Text('Unit measure',style: TextStyle(color: Colors.white70,fontSize: 16),),
                       const SizedBox(width: 7,),
                        DropdownButton<String>(
                          style:const TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor: const Color.fromARGB(255,30, 161, 217),
                          items: <String>['Buc', 'Box', 'Pal'].map((value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          value: unit,
                          onChanged: (item) => setState(() {
                            unit = item;
                            _newProduct.unitMeasure=unit as String;
                          }),
                          icon: const Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                  getTextNumberTextField(context,'Price per unit',_priceUnitFocusNode,(value){_newProduct.pricePerUnit=double.parse(value);}),        
                  getTextNumberTextField(context,'Price per box',_priceBoxFocusNode,(value){_newProduct.pricePerBox=double.parse(value);}),             
                  getTextNumberTextField(context,'Price per pallet',_pricePalletFocusNode,(value){_newProduct.pricePerPallet=double.parse(value);}),                 
                  getTextNumberTextField(context,'Units per box',_boxUnitsFocuNode,(value){_newProduct.unitsPerBox=int.parse(value);}),               
                  getTextNumberTextField(context,'Units per pallet',_palletUnitsFocuNode,(value){_newProduct.unitsPerPallet=int.parse(value);}),
                  Row(
                      children: <Widget>[
                       const  Text('Category',style: TextStyle(color: Colors.white70,fontSize: 16),),
                       const SizedBox(
                          width: 7,
                        ),
                        DropdownButton<String>(
                          style:const TextStyle(color:Colors.white70, fontSize: 16),
                          focusColor: Colors.white60,
                          dropdownColor:const Color.fromARGB(255,30, 161, 217),
                          items: <String>['Drink', 'Chips', 'Coffee','Vitamins','Water','Other'].map((value) {
                            return DropdownMenuItem(value: value, child: Text(value));
                          }).toList(),
                          value: categoryChosen,
                          onChanged: (item) => setState(() {
                            categoryChosen = item;
                            _newProduct.category=categoryChosen as String;
                          }),
                          icon: const Icon(Icons.arrow_drop_down_circle),
                        ),
                      ],
                    ),
                  getTextNumberTextField(context,'stock',_stockFocuNode,(value){_newProduct.stock=double.parse(value);}), 
                  getTextNumberTextField(context,'weight',_weightFocuNode,(value){_newProduct.weight=double.parse(value);}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text('Cancel')),
                        ElevatedButton(onPressed: () {_saveForm();}, child:const Text('Save')),
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

Widget getTextNumberTextField(BuildContext context,String? title,FocusNode focus,Function saveHandler) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
                  decoration:  InputDecoration(
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
                        borderSide:  BorderSide(
                            color: Colors.cyanAccent, width: 2.0)),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: focus,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus();
                  },
                  validator: (value){
                    return Validator.validateDouble(value);
                  },
                  onSaved: (value){saveHandler(value);},
                ),
    );
  }

 Widget getTTExtFormField(BuildContext context,String? text,FocusNode focus,Function savedHandler) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        style: const TextStyle(color: Color.fromARGB(255, 250, 250, 250)),
                  decoration:  InputDecoration(
                    fillColor: const Color.fromARGB(255, 30, 161, 217),
                    filled: true,
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: text,
                    enabledBorder:const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black45, width: 2.0),
                    ),
                    focusedBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide:  BorderSide(
                            color: Colors.cyanAccent, width: 2.0)),
                  ),
                  focusNode: focus,
                  onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                  validator: (value)=>Validator.validateGeneral(value),
                  onSaved:  (value){savedHandler(value);},
                ),
    );
  }
}
