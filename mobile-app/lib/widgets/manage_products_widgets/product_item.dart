import 'modify_widget.dart';
import 'package:flutter/material.dart';
import '../../../model/product.dart' show Product;
import 'package:provider/provider.dart';
import '../../../providers/products.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key,required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 224, 224, 224),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: Row(children: <Widget>[
        Container(
          width: 50,
          margin: EdgeInsets.only(left: 3),
          child: Text(
            '${product.productId}',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 8, right: 3),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        maxLines: 1,
                       product.productName,
                        style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Stock: ${product.stock.toStringAsFixed(2)}'),
                        Text('Price: ${product.priceChoice}'),
                        Text(product.unitMeasure),
                        Text(product.category)
                      ],
                    )
                  ]),
            )),
        Row(
          children: <Widget>[
            IconButton(onPressed: ()  {
              Provider.of<Products>(context,listen:false).deleteProduct(product.productId);

            }, icon: Icon(Icons.delete)),
            IconButton(onPressed: (){
           Navigator.of(context).pushNamed(ProductModifyScreen.routeName,arguments: product);
            }, icon: Icon(Icons.mode_edit)),
          ],
        )
      ]),
    );
  }
}