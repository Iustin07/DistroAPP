import 'package:flutter/cupertino.dart';
class CustomItem{
  int orderId;
  double total;
  double weight;
  CustomItem(this.orderId,this.total,this.weight);
}
class CustomCentralizer with ChangeNotifier{
  List<CustomItem> _ordersId=[];
  int _driverId=-1;
List<CustomItem> get orders{
  return [..._ordersId];
}
  int get itemCount {
    return _ordersId.length;
  }
int get driverId{
  return _driverId;
}
 set driverId(int driverId){
  _driverId=driverId;
}
  double get totalAmount {
    var total = 0.0;
    _ordersId.forEach(( item) {
      total += item.total;
    });
    return total;
  }

  double get totalWeight {
    var total = 0.0;
    _ordersId.forEach((item) {
      total += item.weight;
    });
    return total;
  }
  void addItem(int orderId,double weight,double value) {
    _ordersId.add(CustomItem(orderId, value, weight));
    notifyListeners();
  }
void removeItem(int removeOrderId){
 _ordersId.removeWhere((element) => element.orderId==removeOrderId,);
  notifyListeners();
}
void clear(){
  _ordersId.clear();
  _driverId=-1;
  notifyListeners();
}
}