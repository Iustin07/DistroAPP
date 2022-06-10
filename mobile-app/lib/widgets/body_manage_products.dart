import 'package:distroapp/widgets/auxiliary_widgets/manage_products_widgets/products_list_widget.dart';

import '../widgets/auxiliary_widgets/manage_products_widgets/add_product.dart';
import 'package:flutter/material.dart';
 enum ChosenWidget{LIST,ADD,MODIFY,DEFAULT}

class ManageProductsBody extends StatefulWidget {
 const  ManageProductsBody({Key? key}) : super(key: key);

  @override
  State<ManageProductsBody> createState() => _ManageProductsBodyState();
}

class _ManageProductsBodyState extends State<ManageProductsBody> {
 ChosenWidget selectedWidget=ChosenWidget.DEFAULT;
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0,3),
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(onPressed: (){
                  setState(() {
                    selectedWidget=ChosenWidget.DEFAULT;
                  });
                }, 
                child: Text('home',
                style: TextStyle(color: selectedWidget==ChosenWidget.DEFAULT?Colors.white:Colors.white54),)),
                TextButton(onPressed: (){
                  setState(() {
                    selectedWidget=ChosenWidget.LIST;
                  });
                }, 
                child: Text('List',
                 style: TextStyle(color: selectedWidget==ChosenWidget.LIST?Colors.white:Colors.white54))),
                TextButton(onPressed: (){
                       setState(() {
                    selectedWidget=ChosenWidget.ADD;
                  });
                }, 
                child: Text('Add',
                 style: TextStyle(color: selectedWidget==ChosenWidget.ADD?Colors.white:Colors.white54))),
                TextButton(onPressed: (){
                       setState(() {
                    selectedWidget=ChosenWidget.MODIFY;
                  });
                },
                child: Text('Modify',
                 style: TextStyle(color: selectedWidget==ChosenWidget.MODIFY?Colors.white:Colors.white54)),)
              ],
            ),
          ),
        SizedBox(height:5),
          Container(
          height: MediaQuery.of(context).size.height*0.8,
          child: getCustomContainer(),
          )
        ],
    
      ),
    );
  }
  Widget getCustomContainer(){
    switch(selectedWidget){
      case ChosenWidget.DEFAULT:
        return Container();
      case ChosenWidget.LIST:
        return ProductsList();
      case ChosenWidget.ADD:
        return AddProductScreen();
      case ChosenWidget.MODIFY:
        return Container();
    }
  }
  
}
