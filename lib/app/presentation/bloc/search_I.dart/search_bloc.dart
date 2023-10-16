import 'package:bloc/bloc.dart';
import 'package:rick_and_morty_app/app/presentation/bloc/search_I.dart/search_event.dart';
import 'package:rick_and_morty_app/app/presentation/bloc/search_I.dart/search_state.dart';

import '../../../data/repositories/character_repository_impl.dart';
import '../../../data/repositories/episode_repository_impl.dart';
import '../../../data/repositories/location_repository_impl.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final CharacterRepositoryImpl characterRepository;
  final EpisodeRepositoryImpl episodeRepository;
  final LocationRepositoryImpl locationRepository;

  List<String> selectedCategories = ['character', 'episode', 'location'];

  SearchBloc({
    required this.characterRepository,
    required this.episodeRepository,
    required this.locationRepository,
  }) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<CategoriesChanged>(_onCategoriesChanged);
  }

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    await _searchBasedOnSelectedCategories(event.query, emit);
  }

  void _onCategoriesChanged(
    CategoriesChanged event,
    Emitter<SearchState> emit,
  ) async {
    selectedCategories = event.categories;
    await _searchBasedOnSelectedCategories(
        '', emit); // '' representa una consulta vacía
  }

  Future<void> _searchBasedOnSelectedCategories(
    String query,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    List<dynamic> results = [];

    if (selectedCategories.contains('character')) {
      final characters = await characterRepository.searchCharacters(query);
      results.addAll(characters);
    }
    if (selectedCategories.contains('episode')) {
      final episodes = await episodeRepository.searchEpisodes(query);
      results.addAll(episodes);
    }
    if (selectedCategories.contains('location')) {
      final locations = await locationRepository.searchLocations(query);
      results.addAll(locations);
    }

    emit(SearchSuccess(results: results));
  }
}
