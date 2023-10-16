import '../../domain/entities/episode.dart';
import '../data_sources/episode_remote_data_source.dart';

class EpisodeRepositoryImpl {
  final EpisodeRemoteDataSource remoteDataSource;

  EpisodeRepositoryImpl({required this.remoteDataSource});

  Future<List<Episode>> getEpisodes() async {
    return await remoteDataSource.getEpisodes();
  }

  Future<List<Episode>> searchEpisodes(String query) async {
    final allEpisodes = await getEpisodes();
    return allEpisodes
        .where((episode) =>
            episode.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
