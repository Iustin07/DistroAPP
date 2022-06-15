import 'package:flutter/material.dart';
import '../model/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../properties.dart';
class Products with ChangeNotifier {
  String _token;
  List<Product> _products = [];
  Products(this._token, this._products);
  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse('$serverUrl/products');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      //final extractedData = json.decode(response.body);
      Iterable data = json.decode(response.body);
      _products = data.map((e) => Product.getProductFromJsom(e)).toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse("$serverUrl/products");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          'Authorization': 'Bearer $_token'
        },
        body: json.encode(Product.getMappedProductToJson(product)),
      );
      final createdProduct = (ProductBuilder(jsonDecode(response.body))
            ..productName = product.productName
            ..producer = product.producer
            ..category = product.category
            ..pricePerBox = product.pricePerBox
            ..pricePerPallet = product.pricePerPallet
            ..pricePerUnit = product.pricePerUnit
            ..pricePerBox=product.pricePerBox
            ..pricePerPallet=product.pricePerPallet
            ..unitsPerBox=product.unitsPerBox
            ..unitsPerPallet=product.unitsPerPallet
            ..unitMeasure = product.unitMeasure
            ..stock = product.stock
            ..weight = product.weight)
          .build();
      _products.add(createdProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }


  Future<void> deleteProduct(int id) async {
    final url = Uri.parse("$serverUrl/products/$id");
    final existingProductIndex =
        _products.indexWhere((prod) => prod.productId == id);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    notifyListeners();
    try {
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $_token'},
      );
      if (response.statusCode >= 400) {
        _products.insert(existingProductIndex, existingProduct);
        notifyListeners();
        print('Could not delete product.');
      }
    } catch (error) {
      print(error);
      throw error;
    }
    existingProduct = ProductBuilder(-1).build();
  }
Future<void> modifyProduct(int id, Product product)async{
  final prodIndex=_products.indexWhere((element) => element.productId==id);
final url = Uri.parse('$serverUrl/products/$id');
     try {
       await http.patch(
        url,  
        headers: {"Content-type": "application/json",
          'Authorization':'Bearer $_token'},
        body: json.encode(Product.getMappedProductToJson(product)),
      );
      _products[prodIndex]=product;
       notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }

}
Future<List<Product>> getTopProducts()async{
final url = Uri.parse('$serverUrl/products/top');
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      Iterable data = json.decode(response.body);
     return data.map((e) => Product.getProductFromJsom(e)).toList();
    
    } catch (error) {
      throw (error);
    }
} 
}
