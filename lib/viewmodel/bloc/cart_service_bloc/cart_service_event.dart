import 'package:coffee_online_store/model/models/cart_item_model.dart';

abstract class CartServiceEvent {}

class AddCartItem extends CartServiceEvent {
  final CartItemModel newValue;

  AddCartItem(this.newValue);
}

class RemoveCartItem extends CartServiceEvent {
  final int index;

  RemoveCartItem(this.index);
}

class SaveCart extends CartServiceEvent {
  final List<CartItemModel> newList;

  SaveCart(this.newList);
}

class GetCart extends CartServiceEvent {}

class ClearCart extends CartServiceEvent {}
