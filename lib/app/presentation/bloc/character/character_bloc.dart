import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_characters.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharacters getCharacters;

  CharacterBloc({required this.getCharacters}) : super(CharactersInitial()) {
    on<GetCharactersEvent>((event, emit) async {
      emit(CharactersLoading());
      try {
        final characters = await getCharacters.call();
        emit(CharactersLoaded(characters: characters));
      } catch (e) {
        emit(CharactersError(message: e.toString()));
      }
    });

    on<SearchCharactersEvent>((event, emit) async {
      if (event.query.isEmpty) {
        add(GetCharactersEvent());
        return;
      }
      emit(CharactersLoading());
      try {
        final characters = await getCharacters.call();
        final searchResults = characters
            .where((character) =>
                character.name
                    .toLowerCase()
                    .contains(event.query.toLowerCase()) ||
                character.status
                    .toLowerCase()
                    .contains(event.query.toLowerCase()))
            .toList();
        emit(CharactersLoaded(characters: searchResults));
      } catch (e) {
        emit(CharactersError(message: e.toString()));
      }
    });
  }
}
