import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'map_service_event.dart';
import 'map_service_state.dart';

class MapServiceBloc extends Bloc<MapServiceEvent, MapServiceState> {
  MapServiceBloc() : super(MapInitial()) {
    on<PermissionRequest>(_onPermissionRequest);
    on<GetCurrentPosition>(_onGetCurrentPosition);
  }
  //Ask user permission
  Future<void> _onPermissionRequest(
      PermissionRequest event, Emitter<MapServiceState> emit) async {
    emit(MapLoading());
    try {
      await Geolocator.requestPermission();
      add(GetCurrentPosition());
    } catch (e) {
      emit(MapError(e.toString()));
    }
  }

  //Get user current Location 
  Future<void> _onGetCurrentPosition(
      GetCurrentPosition event, Emitter<MapServiceState> emit) async {
    emit(MapLoading());
    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      ).timeout(const Duration(seconds: 4), onTimeout: () {
        throw TimeoutException("Load user location took too much time.");
      });

      final currentPosition = LatLng(position.latitude, position.longitude);
      emit(MapLoaded(currentPosition));
    } catch (e) {
      emit(
          MapError(e is TimeoutException ? "Loading overtime!" : e.toString()));
    }
  }
}
