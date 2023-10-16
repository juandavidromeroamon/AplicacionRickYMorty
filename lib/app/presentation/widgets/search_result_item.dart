import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';
import '../../domain/entities/episode.dart';
import '../../domain/entities/location.dart';
import '../pages/character/character_detail_page.dart';
import '../pages/episode/episode_detail_page.dart';
import '../pages/location/location_detail_page.dart';

class SearchResultItem extends StatelessWidget {
  final dynamic result;
  final String subtitle;
  final String avatarUrl;
  final double opacity;

  const SearchResultItem({
    Key? key,
    required this.result,
    required this.subtitle,
    required this.avatarUrl,
    required this.opacity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Card(
        color: Colors.white70,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        shadowColor: Colors.black54,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                avatarUrl), // Aquí se utiliza la imagen del personaje.
          ),
          title: Text(
            result.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontSize: 21),
          ),
          onTap: () {
            if (result is Character) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CharacterDetailPage(character: result),
                ),
              );
            } else if (result is Episode) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EpisodeDetailPage(episode: result),
                ),
              );
            } else if (result is Location) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LocationDetailPage(location: result),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
