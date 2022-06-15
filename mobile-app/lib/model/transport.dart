import './transport_item.dart';
import'./review.dart';
class Transport{
int? idTrasnport;
String? producer;
String? dateArrive;
String? driverPhoneNumber;
String? truckRegistraionNumber;
String? driverName;
bool? retour;
double? valueOfProducts;
bool? received;
Review? review;
List<TransportItem>? transportItems=[];
Transport.all({
  this.idTrasnport,
   this.producer,
   this.dateArrive,
   this.driverPhoneNumber,
  this.truckRegistraionNumber,
   this.driverName,
   this.retour,
  this.valueOfProducts,
   this.received,
   this.review,
  this.transportItems
});

static Transport mapJsonToTransport(Map jsonData){
return Transport.all(
  idTrasnport: jsonData["idTransport"],
   producer: jsonData["producer"],
    dateArrive: jsonData["dateArrive"],
     driverPhoneNumber: jsonData["driverPhoneNumber"],
      truckRegistraionNumber: jsonData["truckRegistrationNumber"],
       driverName: jsonData["driverName"],
        retour: jsonData["retour"], 
        valueOfProducts: jsonData["valueOfProducts"],
        received: jsonData["received"],
        review: jsonData["review"]!=null?Review.mapJsonToReview(jsonData["review"]): null,
        transportItems: getListOfProducts(jsonData["productShippingList"])
        );
}

static List<TransportItem> getListOfProducts(Iterable data){
  return data.isEmpty?[]: data.map((e) => TransportItem.mapJsonToTransport(e)).toList();
}
}