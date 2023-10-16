import '../entities/episode.dart';
import '../../data/repositories/episode_repository_impl.dart';

class GetEpisodes {
  final EpisodeRepositoryImpl episodeRepository;

  GetEpisodes(this.episodeRepository);

  Future<List<Episode>> call() {
    return episodeRepository.getEpisodes();
  }
}
