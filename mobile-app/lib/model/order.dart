import './client.dart';
import './orderItem.dart';

class Order{
  int? orderId;
  String? date;
  int? orderSellerAgent;
  Client? client;
  double? orderPaymentValue;
  double? totalWeight;
  List<OrderItem>? orderProducts;
  int? clientId;
  Order.all({
    required this.orderId,
    required this.date,
    required this.orderSellerAgent,
    required this.client,
    required this.orderPaymentValue,
    required this.totalWeight,
    required this.orderProducts,
  });
  Order.selection({
    required this.clientId,
    required this.orderPaymentValue,
    required this.totalWeight,
    required this.orderProducts,
  });
  Map toJson(){
    return 
  { 
  "orderClientId":clientId,
  "orderPaymentValue":orderPaymentValue,
  "totalWeight":totalWeight,
   "productsIds":orderProducts};
}
}