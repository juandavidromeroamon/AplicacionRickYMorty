import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/episode.dart';

class EpisodeRemoteDataSource {
  final http.Client client;

  EpisodeRemoteDataSource({required this.client});

  Future<List<Episode>> getEpisodes() async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/episode'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> episodeMap = json.decode(response.body)['results'];
      return episodeMap.map((e) => Episode.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}
