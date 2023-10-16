import '../../../domain/entities/episode.dart';

abstract class EpisodeState {}

class EpisodesInitial extends EpisodeState {}

class EpisodesLoading extends EpisodeState {}

class EpisodesLoaded extends EpisodeState {
  final List<Episode> episodes;

  EpisodesLoaded({required this.episodes});
}

class EpisodesError extends EpisodeState {
  final String message;

  EpisodesError({required this.message});
}
