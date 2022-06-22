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
  Order get calculatedValuesforValueAndWeight{
    
   final result= orders.reduce((value, element)=>Order.selection(clientId: -1,
   orderPaymentValue: value.orderPaymentValue!+element.orderPaymentValue!,
   totalWeight: value.totalWeight!+element.totalWeight!,
   orderProducts: []
   )
   
   );
   return result;
  }
static Centralizer mapJsonToObeject(Map jsonData){
 return Centralizer(
        centralizerId: jsonData["id"],
        driverName: jsonData["driverName"],
        date: jsonData["creationDate"],
        orders: getOrderFromJson(jsonData["orders"]));
}

static List<Order> getOrderFromJson(Iterable data) {
    return data
        .map((json) => Order.mapOrderFromJson(json["order"]))
        .toList();
  }

}