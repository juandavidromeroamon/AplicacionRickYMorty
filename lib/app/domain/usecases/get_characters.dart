import '../entities/character.dart';
import '../../data/repositories/character_repository_impl.dart';

class GetCharacters {
  final CharacterRepositoryImpl repository;

  GetCharacters({required this.repository});

  Future<List<Character>> call() async {
    return await repository.getCharacters();
  }
}
