class Summar{
  String productName;
  DividerObject divider;
  Summar(this.productName,this.divider);
}
class DividerObject{
int? palletQuantity;
int? boxQuantiy;
int? bucQuantity;
DividerObject({
  required this.palletQuantity,
  required this.boxQuantiy,
  required this.bucQuantity,
});


static DividerObject mapJsonToDivider(Map jsonData){
  return DividerObject(palletQuantity:jsonData["palletQuantity"],
   boxQuantiy: jsonData["boxQuantiy"],
    bucQuantity: jsonData["bucQuantity"]);
}
}