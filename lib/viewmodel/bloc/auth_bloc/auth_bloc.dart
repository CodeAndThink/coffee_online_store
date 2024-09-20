import 'package:coffee_online_store/model/connection/repository/authentication_repository.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authenticationRepository.signIn(event.email, event.password);
      emit(SignInSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authenticationRepository.signUp(event.email, event.password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
