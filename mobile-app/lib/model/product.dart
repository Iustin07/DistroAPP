

class Product{
final int productId;
final String productName;
final String producer;
final String unitMeasure;
final double pricePerUnit;
final double pricePerBox;
final double pricePerPallet;
final int unitsPerBox;
final int unitsPerPallet;
final String category;
final double stock;
final double weight;
get getproductId{
  return productId;
}
get priceChoice{
  if(unitMeasure=='Buc'){
  return pricePerUnit;}
  if(unitMeasure=='Box'){
  return pricePerBox;}
  if(unitMeasure=='Nav'){
  return pricePerBox;}
  if(unitMeasure=='But'){
  return pricePerUnit;}
  

}
Product._builder(ProductBuilder builder):
productId=builder.productId,
productName=builder.productName,
producer=builder.producer,
unitMeasure=builder.unitMeasure,
pricePerUnit=builder.pricePerUnit,
pricePerBox=builder.pricePerBox,
pricePerPallet=builder.pricePerPallet,
unitsPerBox=builder.unitsPerBox,
unitsPerPallet=builder.unitsPerPallet,
category=builder.category,
stock=builder.stock,
weight=builder.weight;

static Product getProductFromJsom(Map json){
  return (ProductBuilder(json["productId"])
  ..productName=json['productName']
  ..producer=json["producerName"]
  ..unitMeasure=json["unitMeasure"]
  ..pricePerUnit=json["pricePerUnit"]
  ..pricePerBox=json["pricePerBox"]
  ..pricePerPallet=json["pricePerPallet"]
  ..unitsPerBox=json["unitsPerBox"]
  ..unitsPerPallet=json["unitsPerPallet"]
  ..category=json["category"]
  ..stock=json["stock"]
  ..weight=json["weight"]).build();
}
static Map<String,dynamic> getMappedProductToJson(Product product){
return
{
'productName':product.productName,
'producerName':product.producer,
'unitMeasure':product.unitMeasure,
'category':product.category,
'pricePerUnit':product.pricePerUnit,
'pricePerBox':product.pricePerBox ,
'pricePerPallet':product.pricePerPallet,
'unitsPerBox':product.unitsPerBox,
'unitsPerPallet':product.unitsPerPallet,
'stock':product.stock,
'weight':product.weight
};
}
}
class ProductBuilder{
 int productId;
String productName='';
String producer='';
 String unitMeasure='';
 double pricePerUnit=0.0;
 double pricePerBox=0.0;
 double pricePerPallet=0.0;
 int unitsPerBox=0;
 int unitsPerPallet=0;
 String category='';
 double stock=0;
 double weight=0.0;
 ProductBuilder(this.productId);
 //ProductBuilder(this.productName);
 void setProductName(String productName){
  this.productName=productName;
}
void setProducer(String producer){
this.producer=producer;
}
void setUnitMeasure(String unitMeasure){
this.unitMeasure=unitMeasure;
}
void setPricePerUnit(double price){
this.pricePerUnit=price;
}
void setPricePerBox(double price){
  this.pricePerBox=price;
}
void setPricePerPallet(double price){
  this.pricePerPallet=price;
}
void setUnitsPerBox(int units){
  this.unitsPerBox=units;
}
void setUnitsPerPallet(int units){
  this.unitsPerPallet=units;
}
void setCategory(String category){
  this.category=category;
}
void setStock(double stock){
  this.stock=stock;
}
void setWeight(double weight){
  this.weight=weight;
}
Product build(){
  return Product._builder(this);
}
@override
  String toString() {
    
    return 'prodductName: ${productName}' +'\n'+ 
    'producerName: ${producer}' +'\n'+
    'unitMeasure: ${unitMeasure}'+'\n'+
    'unitsPerBox: ${unitsPerBox}'+'\n'+
    'unitsPerPallet: ${unitsPerPallet}'+'\n'+
    'stock: ${stock}'+'\n'+
    'weight: ${weight}'+'\n'+
    'category: ${category}'+'\n'
    ;
  }
static ProductBuilder convertProductToBuilder(Product product){
  return ProductBuilder(product.productId)
  ..productName=product.productName
  ..producer=product.producer
  ..category=product.category
..pricePerUnit=product.pricePerUnit
..pricePerBox=product.pricePerBox
..pricePerPallet=product.pricePerPallet
..stock=product.stock
..unitMeasure=product.unitMeasure
..unitsPerPallet=product.unitsPerPallet
..unitsPerBox=product.unitsPerBox
..weight=product.weight;
}

}