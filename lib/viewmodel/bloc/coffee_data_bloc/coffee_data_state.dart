import 'package:coffee_online_store/model/models/coffee_data_model.dart';

abstract class CoffeeDataState {}

class DataInitial extends CoffeeDataState {}

class DataLoading extends CoffeeDataState {}

class DataLoaded extends CoffeeDataState {
  List<CoffeeDataModel> listData;

  DataLoaded(this.listData);
}

class DataError extends CoffeeDataState {
  String message;

  DataError(this.message);
}
