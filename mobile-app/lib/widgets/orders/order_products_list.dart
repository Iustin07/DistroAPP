import './order_product_item.dart';
import 'package:flutter/material.dart';
import '../../../model/product.dart';
import 'package:provider/provider.dart';
import '../../../providers/products.dart';
class OrderProductsList extends StatefulWidget {
   OrderProductsList({Key? key}) : super(key: key);

  @override
  State<OrderProductsList> createState() => _OrderProductsListState();
}

class _OrderProductsListState extends State<OrderProductsList> {
 List<Product> products=[];
 bool _isLoading=false;
 bool _init=true;
 @override
  void initState() {
 
      super.initState();
  }
  @override
  void didChangeDependencies() {
       if(_init){
    setState(() {
      _isLoading=true;
    });
  Provider.of<Products>(context,listen: false).fetchAndSetProducts().then((_){
  setState(() {
    products=Provider.of<Products>(context,listen: false).products;
    products.sort((a,b)=>a.productName.compareTo(b.productName));
      _isLoading=false;
    });});
  }  
  
  
    _init=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
    return _isLoading?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
         child: Container(
          height: MediaQuery.of(context).size.height*0.85,
         child: ListView.builder(
       itemCount: products.length,
       itemBuilder: (ctx,index)=>OrderProductItem(key:ValueKey(products[index].productId.toString()),product: products[index]
        ),
        ),),
    );
  }
}
