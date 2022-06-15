import './client.dart';
import './orderItem.dart';
import './product.dart';
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


static Order  mapOrderFromJson(Map json){
return Order.all(orderId: json["orderId"],
 date: json["orderData"], 
 orderSellerAgent:json["orderSellerAgent"],
  client: getClientFromJson(json["client"]),
  orderPaymentValue: json["orderPaymentValue"],
   totalWeight: json["totalWeight"],
    orderProducts: getMappedOrderProducts(json["products"]));
}
static Client getClientFromJson(Map clientjson){
return Client.all(clientjson["idClient"],
 clientjson["clientName"], 
 clientjson["cif"],
clientjson["commerceRegistrationNumber"],
   clientjson["adress"],
    clientjson["clientPhoneNumber"],
     clientjson["longitude"],
      clientjson["latitude"]);
}
static List<OrderItem> getMappedOrderProducts(Iterable productsjson){
return productsjson.map((prod) =>OrderItem.all(
  prod["opId"],
  getProductFromJsom(prod),
  prod["productUnits"])).toList(); 
}
static Product getProductFromJsom(Map json){
 
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

}