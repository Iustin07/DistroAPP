import 'package:flutter/foundation.dart';
import '../model/review.dart';
import '../model/transport_item.dart';


class TransportCart with ChangeNotifier{
List<TransportItem> _transportItems=[];
Review? review;
void addProduct(TransportItem product){
  _transportItems.add(product);
  notifyListeners();
}
void addReview(Review review){
this.review=review;
notifyListeners();
}

List<TransportItem> get transportItems{
 return [..._transportItems];
}
void removeItem(int productID){
_transportItems.removeWhere((element) => element.productId==productID);
notifyListeners();
}
double get totalValue{
     var total = 0.0;
    _transportItems.forEach(( item) {
      total += item.productValue as double;
    });
    return total;
}
void clear(){
  _transportItems.clear();
  review=null;
  notifyListeners();
}
}