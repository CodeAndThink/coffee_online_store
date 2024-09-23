import 'package:coffee_online_store/model/connection/repository/coffee_data_repository.dart';
import 'package:coffee_online_store/model/models/coffee_bill.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/order_bloc/order_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderServiceBloc extends Bloc<OrderServiceEvent, OrderServiceState> {
  final CoffeeDataRepository _coffeeDataRepository;
  OrderServiceBloc(this._coffeeDataRepository) : super(OrderInitial()) {
    on<CreateNewOrder>(_onCreateNewOrder);
    on<UpdateOrderState>(_onUpdateOrderState);
    on<LoadOrderByUserDocId>(_onLoadOrderByUserDocId);
  }

  Future<void> _onLoadOrderByUserDocId(
      LoadOrderByUserDocId event, Emitter<OrderServiceState> emit) async {
    emit(OrderLoading());

    try {
      if (state is LoadOrderSuccess) {
        final currentState = state as LoadOrderSuccess;
        if (currentState.listBill.isNotEmpty) {
          emit(currentState);
          return;
        }
      }
      final List<CoffeeBill> listCoffeeBills =
          await _coffeeDataRepository.loadCoffeeOrder(event.userDocId);

      emit(LoadOrderSuccess(listCoffeeBills));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onCreateNewOrder(
      CreateNewOrder event, Emitter<OrderServiceState> emit) async {
    emit(OrderLoading());
    try {
      await _coffeeDataRepository.createOrder(event.userDocId, event.cartData,
          event.paymentType, event.deliveryAddress);
      emit(OrderCreateSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onUpdateOrderState(
      UpdateOrderState event, Emitter<OrderServiceState> emit) async {
    emit(OrderLoading());
    try {
      await _coffeeDataRepository.updateDeliveryOrderState(event.orderDocId);
      emit(OrderUpdateStateSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
