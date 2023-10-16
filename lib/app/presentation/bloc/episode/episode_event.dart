abstract class EpisodeEvent {}

class GetEpisodesEvent extends EpisodeEvent {}

class SearchEpisodesEvent extends EpisodeEvent {
  final String query;

  SearchEpisodesEvent(this.query);
}
