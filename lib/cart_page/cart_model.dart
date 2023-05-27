import 'package:flutter/foundation.dart';

class Cart{
  String maDV, id, tenDV, anh, gia;

  Cart({
    required this.maDV,
    required this.id,
    required this.tenDV,
    required this.anh,
    required this.gia,
  });
}
class CartModel extends ChangeNotifier{

  List<dynamic> cartItems = [];

  int get slDV => cartItems.length;

  void addToCart(dynamic serviceSnapshot) {
    if (isInCart(serviceSnapshot) == true) {
      return;
    }
    cartItems.add(serviceSnapshot);
    notifyListeners();
  }

  void removeFromCart(dynamic serviceSnapshot) {
    cartItems.remove(serviceSnapshot);
    notifyListeners();
  }

  bool isInCart(dynamic serviceSnapshot) {
    for(int i in cartItems){
      if(i == serviceSnapshot){
        return true;
      }
    }
    return false;
  }
}






