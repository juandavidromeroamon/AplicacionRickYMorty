import '../../domain/entities/location.dart';
import '../data_sources/location_remote_data_source.dart';

class LocationRepositoryImpl {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  Future<List<Location>> getLocations() async {
    return await remoteDataSource.getLocations();
  }

  Future<List<Location>> searchLocations(String query) async {
    final allLocations = await getLocations();
    return allLocations
        .where((location) =>
            location.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
