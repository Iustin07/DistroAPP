import './order.dart';
class Centralizer{
  int centralizerId;
  String driverName;
  String date;
  List<Order> orders;
Centralizer({
  required this.centralizerId,
  required this.driverName,
  required this.date,
  required this.orders
});
  //double weight;
  Order get calculatedValuesforValueAndWeight{
    
   final result= orders.reduce((value, element)=>Order.selection(clientId: -1,
   orderPaymentValue: value.orderPaymentValue!+element.orderPaymentValue!,
   totalWeight: value.totalWeight!+element.totalWeight!,
   orderProducts: []
   )
   
   );
   return result;
  }
}