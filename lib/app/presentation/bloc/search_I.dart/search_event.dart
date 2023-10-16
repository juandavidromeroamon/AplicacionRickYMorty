abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  final List<String> categories;

  SearchQueryChanged(
      {required this.query,
      this.categories = const ['character', 'episode', 'location']});
}

class CategoriesChanged extends SearchEvent {
  final List<String> categories;

  CategoriesChanged({required this.categories});
}
