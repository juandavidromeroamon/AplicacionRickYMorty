import '../../../domain/entities/location.dart';

abstract class LocationState {}

class LocationsInitial extends LocationState {}

class LocationsLoading extends LocationState {}

class LocationsLoaded extends LocationState {
  final List<Location> locations;

  LocationsLoaded({required this.locations});
}

class LocationsError extends LocationState {
  final String message;

  LocationsError({required this.message});
}
