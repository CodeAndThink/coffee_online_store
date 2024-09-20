import 'coffee_data_model.dart';

class CartItemModel {
  final CoffeeDataModel coffee;
  final int ice;
  final int quantity;
  final int shot;
  final int size;
  final int temp;

  CartItemModel({
    required this.coffee,
    required this.ice,
    required this.quantity,
    required this.shot,
    required this.size,
    required this.temp,
  });

  // Chuyển đổi CartItemModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'coffee': coffee.toJson(),
      'ice': ice,
      'quantity': quantity,
      'shot': shot,
      'size': size,
      'temp': temp,
    };
  }

  // Chuyển từ JSON thành CartItemModel
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      coffee: CoffeeDataModel.fromJson(json['coffee']),
      ice: json['ice'],
      quantity: json['quantity'],
      shot: json['shot'],
      size: json['size'],
      temp: json['temp'],
    );
  }
}
