import './product.dart';
class OrderItem{
  int? id;
  Product? product;
  int? opProductId;
  int? productUnits;
  OrderItem.all(this.id,this.product,this.productUnits);
  OrderItem.custom({
    required this.opProductId,
    required this.productUnits});
  Map<String,dynamic> toJson()=>{
    "opProductId":opProductId,
  "productUnits":productUnits
  };
}