import 'package:coffee_online_store/model/connection/repository/coffee_data_repository.dart';
import 'package:coffee_online_store/model/models/coffee_data_model.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/coffee_data_bloc/coffee_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeDataBloc extends Bloc<CoffeeDataEvent, CoffeeDataState> {
  final CoffeeDataRepository _coffeeDataRepository;
  CoffeeDataBloc(this._coffeeDataRepository) : super(DataInitial()) {
    on<FetchCoffeeType>(_onFetchCoffeeType);
  }

  Future<void> _onFetchCoffeeType(
      FetchCoffeeType event, Emitter<CoffeeDataState> emit) async {
    emit(DataLoading());
    try {
      final List<CoffeeDataModel> response =
          await _coffeeDataRepository.loadCoffeeTypes();
      emit(DataLoaded(response));
    } catch (e) {
      emit(DataError(e.toString()));
    }
  }
}
