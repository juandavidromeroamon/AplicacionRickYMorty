abstract class CharacterEvent {}

class GetCharactersEvent extends CharacterEvent {}

class SearchCharactersEvent extends CharacterEvent {
  final String query;

  SearchCharactersEvent(this.query);
}
