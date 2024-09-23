import 'package:coffee_online_store/model/connection/repository/authentication_repository.dart';
import 'package:coffee_online_store/model/models/user_metadata_model.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthBloc(this._authenticationRepository) : super(AuthInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  // Signin
  Future<void> _onSignInEvent(
      SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final UserCredential userCredential =
          await _authenticationRepository.signIn(event.email, event.password);

      emit(SignInSuccess(userCredential));

      final UserMetadataModel? userMetadata =
          await _authenticationRepository.getUserData(userCredential.user!.uid);

      if (userMetadata != null) {
        emit(LoadUserDataSuccess(userMetadata));
        await _authenticationRepository.saveUserProfile(userMetadata);
      } else {
        emit(AuthError('No user data available!'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  //Signout
  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authenticationRepository.signUp(
          event.displayName, event.phoneNumber, event.email, event.password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
