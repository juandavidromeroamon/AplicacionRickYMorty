import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/character.dart';

class CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSource({required this.client});

  Future<List<Character>> getCharacters() async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> characterMap = json.decode(response.body)['results'];
      return characterMap.map((e) => Character.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
