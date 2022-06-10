class Client{
int? id;
String? clientName;
String? cif;
String? registration;
String? address;
String? phoneNumber;
double? longitude;
double? latitude;
Client.all(
this.id,
this.clientName,
this.cif,
this.registration,
this.address,
this.phoneNumber,
this.longitude,
this.latitude);
Client.custom({
  required this.id,
  required this.clientName,
  required this.phoneNumber,
});

static Client mapJsonToClient(Map jsonData){
  return Client.all(jsonData["idClient"],
   jsonData["clientName"],
    jsonData["cif"],
    jsonData["commerceRegistrationNumber"],
      jsonData["address"],
       jsonData["clientPhoneNumber"],
        jsonData["longitude"],
        jsonData["latitude"]);
}
}