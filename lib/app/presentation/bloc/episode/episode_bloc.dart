import 'package:flutter_bloc/flutter_bloc.dart';
import 'episode_event.dart';
import 'episode_state.dart';
import '../../../domain/usecases/get_episodes.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetEpisodes getEpisodes;

  EpisodeBloc({required this.getEpisodes}) : super(EpisodesInitial()) {
    on<GetEpisodesEvent>((event, emit) async {
      emit(EpisodesLoading());
      try {
        final episodes = await getEpisodes();
        emit(EpisodesLoaded(episodes: episodes));
      } catch (e) {
        emit(EpisodesError(message: e.toString()));
      }
    });

    on<SearchEpisodesEvent>((event, emit) async {
      if (event.query.isEmpty) {
        add(GetEpisodesEvent());
      } else {
        emit(EpisodesLoading());
        try {
          final episodes = await getEpisodes();
          final searchResults = episodes
              .where((episode) =>
                  episode.name
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  episode.airDate
                      .toLowerCase()
                      .contains(event.query.toLowerCase()))
              .toList();
          emit(EpisodesLoaded(episodes: searchResults));
        } catch (e) {
          emit(EpisodesError(message: e.toString()));
        }
      }
    });
  }
}
