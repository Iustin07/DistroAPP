import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../model/product.dart';
import '../../widgets/manage_products_widgets/product_item.dart';
class TopProductsList extends StatefulWidget {
  const TopProductsList({Key? key}) : super(key: key);

  @override
  State<TopProductsList> createState() => _TopProductsListState();
}

class _TopProductsListState extends State<TopProductsList> {
  List<Product>? topProducts;
  bool _init=true;
  bool _isLoading=false;

  
@override
  void didChangeDependencies() {
   if(_init){
setState(() {
  _isLoading=true;
});
Provider.of<Products>(context).getTopProducts().then((value){
  setState(() {
    topProducts=List.from(value);
    _isLoading=false;
  });
});
   }
   _init=false;
    super.didChangeDependencies();
  }  
  @override
  Widget build(BuildContext context) {
      return 
         _isLoading?const Center(child: CircularProgressIndicator(),): Container(
           height: 300,
           child: ListView.builder(
             shrinkWrap: true,
                physics:const  NeverScrollableScrollPhysics(),
       itemCount: topProducts!.length,
       itemBuilder: (ctx,index)=>ProductItem(key:ValueKey(topProducts![index].productId.toString()),product: topProducts![index]
        ),
        ),
         
    );
  }
}
