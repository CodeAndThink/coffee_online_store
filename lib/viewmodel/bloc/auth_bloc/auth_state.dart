import 'package:coffee_online_store/model/models/user_metadata_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final UserCredential userData;

  SignInSuccess(this.userData);
}

class LoadUserDataSuccess extends AuthState {
  final UserMetadataModel userData;

  LoadUserDataSuccess(this.userData);
}

class SignUpSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
