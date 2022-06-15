import './product.dart';
class Lost{
int? id;
String? responsableName;
Product? product;
double? quantity;
String? dateOfLost;
Lost.all({
  required this.id,
  required this.responsableName,
  required this.product,
  required this.quantity,
  required this.dateOfLost});

static Map mapLostToJson(int productId, double quantity){
  return {
    "productId":productId,
    "quantity":quantity,
  };
}
static Lost  mapFromJsonToLost(Map jsonData){
  return Lost.all(
id:jsonData["id"],
responsableName: jsonData["responsableName"],
product: Product.getProductFromJsom(jsonData["product"]),
quantity: jsonData["quantity"],
dateOfLost: jsonData["dateOfLost"]
  );
}
}