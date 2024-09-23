import 'package:coffee_online_store/model/connection/repository/authentication_repository.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_event.dart';
import 'package:coffee_online_store/viewmodel/bloc/auth_bloc/auth_service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthServiceBloc extends Bloc<AuthServiceEvent, AuthServiceState> {
  final AuthenticationRepository _authenticationRepository;
  AuthServiceBloc(this._authenticationRepository)
      : super(AuthServiceInitial()) {
    on<GetLocalUserProfile>(_onGetLocalUserProfile);
    on<SaveLocalUserProfile>(_onSaveLocalUserProfile);
  }

  Future<void> _onGetLocalUserProfile(
      GetLocalUserProfile event, Emitter<AuthServiceState> emit) async {
    emit(AuthServiceLoading());
    try {
      final userMetadata =
          await _authenticationRepository.getLocalUserProfile();
      if (userMetadata != null) {
        emit(LoadLocalUserProfileSuccess(userMetadata));
      } else {
        emit(AuthServiceError('No data available!'));
      }
    } catch (e) {
      emit(AuthServiceError(e.toString()));
    }
  }

  Future<void> _onSaveLocalUserProfile(
      SaveLocalUserProfile event, Emitter<AuthServiceState> emit) async {
    emit(AuthServiceLoading());
    try {
      emit(SaveLocalUserProfileSuccesss());
    } catch (e) {
      emit(AuthServiceError(e.toString()));
    }
  }
}
