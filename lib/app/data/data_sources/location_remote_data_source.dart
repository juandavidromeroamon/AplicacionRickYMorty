import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/location.dart';

class LocationRemoteDataSource {
  final http.Client client;

  LocationRemoteDataSource({required this.client});

  Future<List<Location>> getLocations() async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/location'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> locationMap = json.decode(response.body)['results'];
      return locationMap.map((e) => Location.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}
