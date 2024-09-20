import 'package:coffee_online_store/model/connection/local/cart_service.dart';
import 'package:coffee_online_store/model/models/cart_item_model.dart';

class CoffeeDataRepository {
  final CartService _cartService;

  CoffeeDataRepository(this._cartService);

  Future<void> saveCart(List<CartItemModel> cartItems) async {
    await _cartService.saveCart(cartItems);
  }

  Future<List<CartItemModel>> getCart() async {
    return await _cartService.getCart();
  }

  Future<void> clearCart() async {
    await _cartService.clearCart();
  }
}
