import 'package:latlong2/latlong.dart';

abstract class MapServiceState {}

class MapInitial extends MapServiceState {}

class MapLoading extends MapServiceState {}

class MapLoaded extends MapServiceState {
  final LatLng position;

  MapLoaded(this.position);
}

class PermissionGained extends MapServiceState {
  
}

class MapError extends MapServiceState {
  final String message;

  MapError(this.message);
}
