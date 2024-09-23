import 'package:coffee_online_store/model/models/cart_item_model.dart';

class CoffeeBill {
  final String userDocId;
  final List<CartItemModel> listOrderCoffee;
  final DateTime orderTime;
  final int paymentType;
  final String deliveryAddress;
  bool deliveryState;

  CoffeeBill(
      {required this.userDocId,
      required this.listOrderCoffee,
      required this.orderTime,
      required this.paymentType,
      required this.deliveryAddress,
      required this.deliveryState});

  // Chuyển đổi từ JSON sang CoffeeBill
  factory CoffeeBill.fromJson(Map<String, dynamic> json) {
    return CoffeeBill(
        userDocId: json['userDocId'],
        listOrderCoffee: (json['listOrderCoffee'] as List)
            .map((item) => CartItemModel.fromJson(item))
            .toList(),
        orderTime: DateTime.parse(json['orderTime']),
        paymentType: json['paymentType'],
        deliveryAddress: json['deliveryAddress'],
        deliveryState: json['deliveryState']);
  }

  // Chuyển đổi từ CoffeeBill sang JSON
  Map<String, dynamic> toJson() {
    return {
      'userDocId': userDocId,
      'listOrderCoffee': listOrderCoffee.map((item) => item.toJson()).toList(),
      'orderTime': orderTime.toIso8601String(),
      'paymentType': paymentType,
      'deliveryAddress': deliveryAddress,
      'deliveryState': deliveryState
    };
  }
}
