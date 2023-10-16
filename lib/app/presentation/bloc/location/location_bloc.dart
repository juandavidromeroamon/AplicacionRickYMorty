import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_locations.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocations getLocations;

  LocationBloc({required this.getLocations}) : super(LocationsInitial()) {
    on<GetLocationsEvent>((event, emit) async {
      emit(LocationsLoading());
      try {
        final locations = await getLocations.call();
        emit(LocationsLoaded(locations: locations));
      } catch (e) {
        emit(LocationsError(message: e.toString()));
      }
    });

    on<SearchLocationsEvent>((event, emit) async {
      if (event.query.isEmpty) {
        add(GetLocationsEvent());
        return;
      }
      emit(LocationsLoading());
      try {
        final locations = await getLocations.call();
        final searchResults = locations
            .where((location) =>
                location.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                location.type.toLowerCase().contains(event.query.toLowerCase()))
            .toList();
        emit(LocationsLoaded(locations: searchResults));
      } catch (e) {
        emit(LocationsError(message: e.toString()));
      }
    });
  }
}
