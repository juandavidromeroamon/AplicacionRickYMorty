import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, String> {
  NavigationBloc() : super('/');

  Stream<String> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.toCharacter:
        yield '/character';
        break;
      case NavigationEvent.toLocation:
        yield '/location';
        break;
      case NavigationEvent.toEpisode:
        yield '/episode';
        break;
    }
  }
}

enum NavigationEvent { toCharacter, toLocation, toEpisode }
