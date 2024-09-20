abstract class CoffeeDataState {}

class DataInitial extends CoffeeDataState {}

class DataLoading extends CoffeeDataState {}

class DataLoaded extends CoffeeDataState {}

class DataError extends CoffeeDataState {
  final String message;

  DataError(this.message);
}