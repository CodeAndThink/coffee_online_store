import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:coffee_online_store/model/models/coffee_bill.dart';
import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoffeeDataRepository {
  final FirebaseFirestore _firebaseFirestore;

  CoffeeDataRepository(this._firebaseFirestore);

  //Create order
  Future<void> createOrder(String userDocId, List<CartItemModel> listOrderCoffee,
      int paymentType, String deliveryAddress) async {
    CoffeeBill newBill = CoffeeBill(
        userDocId: userDocId,
        listOrderCoffee: listOrderCoffee,
        orderTime: DateTime.now(),
        paymentType: paymentType,
        deliveryAddress: deliveryAddress,
        deliveryState: false);
    await _firebaseFirestore.collection('orders').doc().set(newBill.toJson());
  }

  //Get orders list
  Future<List<CoffeeBill>> loadCoffeeOrder(String userDocId) async {
    try {
      var querySnapshot = await _firebaseFirestore
          .collection('orders')
          .where('userDocId', isEqualTo: userDocId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs
            .map((doc) =>
                CoffeeBill.fromJson(doc.data()))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  //Update orders state
  Future<void> updateDeliveryOrderState(String orderDocId) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('orders').doc(orderDocId).get();
    bool currentState = snapshot['deliveryState'];
    bool newState = !currentState;
    return await _firebaseFirestore
        .collection('orders')
        .doc(orderDocId)
        .update({'deliveryState': newState});
  }

  //Coffee data services
  Future<List<CoffeeDataModel>> loadCoffeeTypes() async {
    List<CoffeeDataModel> coffeeList = [];
    try {
      QuerySnapshot snapshot =
          await _firebaseFirestore.collection('coffee_types').get();
      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        CoffeeDataModel coffee = CoffeeDataModel.fromJson(data);
        coffeeList.add(coffee);
      }
    } catch (e) {
      print("Error getting documents: $e");
    }
    return coffeeList;
  }

  //Save
  Future<void> saveCart(List<CartItemModel> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson =
        jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  //get
  Future<List<CartItemModel>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      List<dynamic> decodedJson = jsonDecode(cartJson);
      return decodedJson.map((item) => CartItemModel.fromJson(item)).toList();
    }
    return [];
  }

  //Clear cart list items
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }
}
