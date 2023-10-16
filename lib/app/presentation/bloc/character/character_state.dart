import '../../../domain/entities/character.dart';

abstract class CharacterState {}

class CharactersInitial extends CharacterState {}

class CharactersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  final List<Character> characters;

  CharactersLoaded({required this.characters});
}

class CharactersError extends CharacterState {
  final String message;

  CharactersError({required this.message});
}
