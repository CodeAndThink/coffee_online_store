import 'package:coffee_online_store/model/connection/repository/coffee_data_repository.dart';
import 'package:coffee_online_store/model/models/cart_item_model.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/cart_service_bloc/cart_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartServiceBloc extends Bloc<CartServiceEvent, CartServiceState> {
  final CoffeeDataRepository _coffeeDataRepository;
  CartServiceBloc(this._coffeeDataRepository) : super(CartInitial()) {
    on<SaveCart>(_onSaveCart);
    on<AddCartItem>(_onAddCartItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<GetCart>(_onGetCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onAddCartItem(
      AddCartItem event, Emitter<CartServiceState> emit) async {
    emit(CartLoading());
    try {
      final List<CartItemModel> cartList =
          await _coffeeDataRepository.loadCartItems();

      final existingItemIndex = cartList.indexWhere((item) =>
          item.coffee.name == event.newValue.coffee.name &&
          item.ice == event.newValue.ice &&
          item.shot == event.newValue.shot &&
          item.size == event.newValue.size &&
          item.temp == event.newValue.temp);

      if (existingItemIndex != -1) {
        cartList[existingItemIndex].quantity += event.newValue.quantity;
      } else {
        cartList.add(event.newValue);
      }

      await _coffeeDataRepository.saveCart(cartList);
      emit(CartSaveSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveCartItem(
      RemoveCartItem event, Emitter<CartServiceState> emit) async {
    emit(CartLoading());
    try {
      final List<CartItemModel> oldCartList =
          await _coffeeDataRepository.loadCartItems();

      oldCartList.removeAt(event.index);
      await _coffeeDataRepository.saveCart(oldCartList);

      emit(CartLoaded(oldCartList));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onSaveCart(
      SaveCart event, Emitter<CartServiceState> emit) async {
    emit(CartLoading());
    try {
      await _coffeeDataRepository.saveCart(event.newList);
      emit(CartSaveSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onGetCart(GetCart event, Emitter<CartServiceState> emit) async {
    emit(CartLoading());
    try {
      final List<CartItemModel> listData =
          await _coffeeDataRepository.loadCartItems();
      emit(CartLoaded(listData));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onClearCart(
      ClearCart event, Emitter<CartServiceState> emit) async {
    emit(CartLoading());
    try {
      await _coffeeDataRepository.clearCart();
      emit(CartClearSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
