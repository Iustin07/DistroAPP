
import 'package:distroapp/model/httpexception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/order.dart';
import '../model/orderItem.dart';
import '../model/client.dart';
import '../model/product.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/cart.dart' show CartItem;
import 'package:intl/intl.dart';
class Orders with ChangeNotifier{
List<Order> _orders=[];
String _token;
Orders(this._token);
List<Order> get orders{
  return[..._orders];
}
double get getTotalValue{
  double sum=0.0;
 _orders.forEach((order) { sum+=order.orderPaymentValue as double;});
return sum;
}
double get getTotalWeight{
  double sum=0.0;
   _orders.forEach((order) { sum+=order.totalWeight as double;});
return sum;
}
Future<void> readJson() async {
  print('call for readJson');
    final String response = await rootBundle.loadString('lib/data/orders.json');
    Iterable data = await json.decode(response);
     _orders=data.map((e) => getOrderFromJson(e)).toList();
  notifyListeners();
}
Order getOrderFromJson(Map json){
return Order.all(orderId: json["orderId"],
 date: json["orderData"], 
 orderSellerAgent:json["orderSellerAgent"],
  client: getClientFromJson(json["client"]),
  orderPaymentValue: json["orderPaymentValue"],
   totalWeight: json["totalWeight"],
    orderProducts: getMappedOrderProducts(json["products"]));
}
Client getClientFromJson(Map clientjson){
return Client.all(clientjson["idClient"],
 clientjson["clientName"], 
 clientjson["cif"],
clientjson["commerceRegistrationNumber"],
   clientjson["adress"],
    clientjson["clientPhoneNumber"],
     clientjson["longitude"],
      clientjson["latitude"]);
}
List<OrderItem> getMappedOrderProducts(Iterable productsjson){
return productsjson.map((prod) =>OrderItem.all(
  prod["opId"],
  getProductFromJsom(prod),
  prod["productUnits"])).toList(); 
}
Product getProductFromJsom(Map json){
 
  return (ProductBuilder(json["product"]["productId"])
  ..productName=json["product"]['productName']
  ..producer=json["product"]["producerName"]
  ..unitMeasure=json["product"]["unitMeasure"]
  ..pricePerUnit=json["product"]["pricePerUnit"]
  ..pricePerBox=json["product"]["pricePerBox"]
  ..pricePerPallet=json["product"]["pricePerPallet"]
  ..unitsPerBox=json["product"]["unitsPerBox"]
  ..unitsPerPallet=json["product"]["unitsPerPallet"]
  ..category=json["product"]["category"]
  ..stock=json["product"]["stock"]
  ..weight=json["product"]["weight"]).build();
}

void removeOrderItem(int orderItemId, int orderId)async{
   final url=Uri.parse("http://192.168.0.103:3000/orderProducts/cancel?id=$orderItemId");
        try {
      final response = await http.delete(url,
        headers: {'Authorization':'Bearer $_token'},
       );
       notifyListeners();
    } catch (error) {
      throw (error);
    }
   final order= _orders.firstWhere((element) => element.orderId==orderId);
    final index= _orders.indexOf(order);
   final orderProduct=order.orderProducts!.firstWhere((element) => element.id==orderItemId);
   order.orderPaymentValue=order.orderPaymentValue!-orderProduct.productUnits!*orderProduct.product!.priceChoice;
   order.totalWeight=order.totalWeight!-orderProduct.productUnits!*orderProduct.product!.weight;
   order.orderProducts!.remove(orderProduct);
   _orders[index]=order;
notifyListeners();
}

  Future <dynamic> addOrder(Iterable<CartItem> items, double totalAmount, double totalWeight, int clienId) async{
    final url=Uri.parse("http://192.168.0.103:3000/orders");
    List<OrderItem> products=items.map((e) => OrderItem.custom(opProductId: e.productId,productUnits: e.quantity)).toList();
    print(products);
    final order=Order.selection(
      clientId: clienId,
      orderPaymentValue: totalAmount,
      totalWeight: totalWeight,
      orderProducts: products
    );
        try {
      final response = await http.post(
        url,
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode(order),
      );
    
       notifyListeners();
       return response;
    } catch (error) {
      print(error);
      throw error;
    }
  }
Future<dynamic> fetchOrderOfAgent(int agentId,  String date)async{
  print('call orders fetch');
    final url=Uri.parse("http://192.168.0.103:3000/orders/?agentId=${agentId}&date=${date}");
        try {
      final response = await http.get(url,
        headers: {'Authorization':'Bearer $_token'},
       );
      Iterable data = json.decode(response.body);
     _orders= data.map((e) => getOrderFromJson(e)).toList();
    if(response.statusCode==200)
    return 200;
    else
    return 404;
    } catch (error) {
      print(error);
      throw error;
    }
}
Future<void> cancelOrder(int orderId) async{
final url=Uri.parse("http://192.168.0.103:3000/orders/cancel?id=$orderId");
        try {
      final response = await http.delete(url,
        headers: {'Authorization':'Bearer $_token'},
       );
       _orders.removeWhere((element) => element.orderId==orderId);
       notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
}  
void removeOrderFromList(int orderId){
  _orders.removeWhere((element) => element.orderId==orderId);
  notifyListeners();
}
Future<double> getIncome()async{
  final url=Uri.parse("http://192.168.0.103:3000/orders/income");
        try {
      final response = await http.get(url,
        headers: {'Authorization':'Bearer $_token'},
       );
      dynamic data=response.body;

      return double.parse(data);
    } catch (error) {
      print(error);
      throw error;
    }
}
}