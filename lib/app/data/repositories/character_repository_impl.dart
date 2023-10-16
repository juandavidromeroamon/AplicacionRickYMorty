import '../../domain/entities/character.dart';
import '../data_sources/character_remote_data_source.dart';

class CharacterRepositoryImpl {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  Future<List<Character>> getCharacters() async {
    return await remoteDataSource.getCharacters();
  }

  Future<List<Character>> searchCharacters(String query) async {
    final allCharacters = await getCharacters();
    return allCharacters
        .where((character) =>
            character.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
