import 'dart:convert';

import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  // Lưu danh sách giỏ hàng
  Future<void> saveCart(List<CartItemModel> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    // Chuyển đổi list CartItemModel thành JSON
    final cartJson =
        jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  // Lấy danh sách giỏ hàng
  Future<List<CartItemModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      // Chuyển từ JSON thành list CartItemModel
      List<dynamic> decodedJson = jsonDecode(cartJson);
      return decodedJson.map((item) => CartItemModel.fromJson(item)).toList();
    }
    return [];
  }

  // Xóa giỏ hàng
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }
}
