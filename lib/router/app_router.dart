import 'package:flutter/material.dart';

import '../app/presentation/pages/character/character_page.dart';

import '../app/presentation/pages/episode/episode_page.dart';
import '../app/presentation/pages/home_page.dart';

import '../app/presentation/pages/location/location_page.dart';
import '../app/presentation/pages/search_page.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/character':
        return MaterialPageRoute(builder: (_) => CharacterPage());
      case '/location':
        return MaterialPageRoute(builder: (_) => LocationPage());
      case '/episode':
        return MaterialPageRoute(builder: (_) => EpisodePage());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Error: Página no encontrada')),
          ),
        );
    }
  }
}
