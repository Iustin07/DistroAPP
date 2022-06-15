import 'package:distroapp/model/transport.dart';

import 'product.dart';
class TransportItem{
  int? id;
  int? idTransport;
  Product? product;
 double? productQuantity;
 String? unityMeasure;
 double? productValue;
 int? productId;
 String? productName;
 TransportItem.all({
   required this.id,
   required this.idTransport,
   required this.product,
   required this.productQuantity,
   required this.unityMeasure,
   required this.productValue,
 });
 TransportItem.custom({
   required this.productId,
   required this.productQuantity,
   required this.unityMeasure,
   required this.productValue
 });
 TransportItem.cart({
    required this.productId,
    required this.productName,
   required this.productQuantity,
   required this.unityMeasure,
   required this.productValue
 });
 static TransportItem mapJsonToTransport(Map jsonData){
   return TransportItem.all(id: jsonData["psId"],
    idTransport: jsonData["psIdTransport"],
    product: Product.getProductFromJsom(jsonData["product"]),
     productQuantity: jsonData["productQuantity"],
      unityMeasure: jsonData["unityMeasure"],
       productValue: jsonData["productValue"]);
 }
  Map<String, dynamic> toJson() {
    return {
        "psProductId":productId,
        "productQuantity":productQuantity,
        "unityMeasure":unityMeasure,
        "productValue":productValue
    };
  }
}