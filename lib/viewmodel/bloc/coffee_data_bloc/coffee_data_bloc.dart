import 'package:coffee_online_store/model/connection/repository/coffee_data_repository.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeDataBloc extends Bloc<CoffeeDataEvent, CoffeeDataState> {
  final CoffeeDataRepository _coffeeDataRepository;
  CoffeeDataBloc(this._coffeeDataRepository) : super(DataInitial()) {
    on<FetchCoffeeType>(_onFetchCoffeeType);
  }

  Future<void> delay(Duration duration) async {
    await Future.delayed(duration);
  }

  Future<void> _onFetchCoffeeType(
      FetchCoffeeType event, Emitter<CoffeeDataState> emit) async {
    emit(DataLoading());
    try {
      await delay(const Duration(seconds: 5));
      emit(DataLoaded());
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }
}
