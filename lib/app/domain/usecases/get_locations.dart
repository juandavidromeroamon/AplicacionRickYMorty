import '../entities/location.dart';
import '../../data/repositories/location_repository_impl.dart';

class GetLocations {
  final LocationRepositoryImpl repository;

  GetLocations({required this.repository});

  Future<List<Location>> call() async {
    try {
      final locations = await repository.getLocations();
      return locations;
    } catch (error) {
      // Manejar error
      throw Exception('Failed to load locations');
    }
  }
}
