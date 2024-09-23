import 'package:coffee_online_store/model/models/coffee_bill.dart';
import 'package:equatable/equatable.dart';

abstract class OrderServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderServiceState {
}

class OrderLoading extends OrderServiceState {}

class OrderCreateSuccess extends OrderServiceState {}

class OrderUpdateStateSuccess extends OrderServiceState {}

class LoadOrderSuccess extends OrderServiceState {
  final List<CoffeeBill> listBill;

  LoadOrderSuccess(this.listBill);

  @override
  List<Object?> get props => [listBill];
}

class OrderError extends OrderServiceState {
  final String message;

  OrderError(this.message);
}
