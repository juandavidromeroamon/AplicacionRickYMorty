// <--- Esto es necesario para el http.Client()

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/data/data_sources/character_remote_data_source.dart';
import 'app/data/data_sources/episode_remote_data_source.dart';
import 'app/data/data_sources/location_remote_data_source.dart';
import 'app/data/repositories/character_repository_impl.dart';
import 'app/data/repositories/episode_repository_impl.dart';
import 'app/data/repositories/location_repository_impl.dart';
import 'app/domain/usecases/get_characters.dart';
import 'app/domain/usecases/get_episodes.dart';
import 'app/domain/usecases/get_locations.dart';
import 'app/presentation/bloc/character/character_bloc.dart';
import 'app/presentation/bloc/character/character_event.dart';
import 'app/presentation/bloc/episode/episode_bloc.dart';
import 'app/presentation/bloc/episode/episode_event.dart';
import 'package:http/http.dart' as http;
import 'app/presentation/bloc/location/location_bloc.dart';
import 'app/presentation/bloc/location/location_event.dart';
import 'app/presentation/bloc/navigation_bloc.dart';
import 'app/presentation/bloc/search_I.dart/search_bloc.dart';

import 'router/app_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) => CharacterBloc(
            getCharacters: GetCharacters(
              repository: CharacterRepositoryImpl(
                remoteDataSource:
                    CharacterRemoteDataSource(client: http.Client()),
              ),
            ),
          )..add(GetCharactersEvent()),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(
            getLocations: GetLocations(
              repository: LocationRepositoryImpl(
                remoteDataSource:
                    LocationRemoteDataSource(client: http.Client()),
              ),
            ),
          )..add(GetLocationsEvent()),
        ),
        BlocProvider<EpisodeBloc>(
          create: (context) => EpisodeBloc(
            getEpisodes: GetEpisodes(
              EpisodeRepositoryImpl(
                remoteDataSource:
                    EpisodeRemoteDataSource(client: http.Client()),
              ),
            ),
          )..add(GetEpisodesEvent()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(
            characterRepository: CharacterRepositoryImpl(
              remoteDataSource:
                  CharacterRemoteDataSource(client: http.Client()),
            ),
            episodeRepository: EpisodeRepositoryImpl(
              remoteDataSource: EpisodeRemoteDataSource(client: http.Client()),
            ),
            locationRepository: LocationRepositoryImpl(
              remoteDataSource: LocationRemoteDataSource(client: http.Client()),
            ),
          ),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
