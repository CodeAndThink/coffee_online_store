import 'package:coffee_online_store/model/models/cart_item_model.dart';

abstract class OrderServiceEvent {}

class CreateNewOrder extends OrderServiceEvent {
  final String userDocId;
  final List<CartItemModel> cartData;
  final int paymentType;
  final String deliveryAddress;

  CreateNewOrder(
      this.userDocId, this.cartData, this.paymentType, this.deliveryAddress);
}

class LoadOrderByUserDocId extends OrderServiceEvent {
  final String userDocId;

  LoadOrderByUserDocId(this.userDocId);
}

class UpdateOrderState extends OrderServiceEvent {
  final String orderDocId;

  UpdateOrderState(this.orderDocId);
}
