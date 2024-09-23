import 'package:coffee_online_store/model/models/user_metadata_model.dart';

abstract class AuthServiceState {}

class AuthServiceInitial extends AuthServiceState {}

class AuthServiceLoading extends AuthServiceState {}

class SaveLocalUserProfileSuccesss extends AuthServiceState {}

class LoadLocalUserProfileSuccess extends AuthServiceState {
  final UserMetadataModel userMetadata;

  LoadLocalUserProfileSuccess(this.userMetadata);
}

class AuthServiceError extends AuthServiceState {
  final String message;

  AuthServiceError(this.message);
}
