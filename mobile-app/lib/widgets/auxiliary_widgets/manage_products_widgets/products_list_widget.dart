import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
import '../../../model/product.dart';
import '../../../providers/products.dart';
class ProductsList extends StatefulWidget {
 ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  bool _loading=false;
  bool _isInit=true;
  List<Product> _products=[];
  @override
  void dispose() {
    _isInit=true;
    _products.clear();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _loading=true;
      });
Provider.of<Products>(context).fetchAndSetProducts().then((_) {
  setState(() {
    _loading=false;
  });
} 

);
    }
    _isInit=false;
    super.didChangeDependencies();
  }
@override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     _products=Provider.of<Products>(context).products;
    return _loading? Center(child: CircularProgressIndicator(),):
     SingleChildScrollView(
         child: ConstrainedBox(
           constraints: BoxConstraints(maxHeight:MediaQuery.of(context).size.height*0.85 ),
          //height: MediaQuery.of(context).size.height*0.8,
         child: ListView.builder(
       itemCount: _products.length,
       itemBuilder: (ctx,index)=>ProductItem(key:ValueKey(_products[index].productId.toString()),product: _products[index]), 
       
   
        ),),
    );
  }
}