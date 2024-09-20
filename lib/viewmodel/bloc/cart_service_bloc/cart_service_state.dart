import 'package:coffee_online_store/model/models/cart_item_model.dart';

abstract class CartServiceState {}

class CartInitial extends CartServiceState {}

class CartLoading extends CartServiceState {}

class CartClearSuccess extends CartServiceState {}

class CartSaveSuccess extends CartServiceState {}

class CartLoaded extends CartServiceState {
  List<CartItemModel> listCartItem;

  CartLoaded(this.listCartItem);
}

class CartError extends CartServiceState {
  final String message;

  CartError(this.message);
}
