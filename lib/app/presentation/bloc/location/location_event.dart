abstract class LocationEvent {}

class GetLocationsEvent extends LocationEvent {}

class SearchLocationsEvent extends LocationEvent {
  final String query;

  SearchLocationsEvent(this.query);
}
