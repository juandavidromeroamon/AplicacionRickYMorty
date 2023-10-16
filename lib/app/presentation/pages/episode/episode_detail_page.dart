import 'package:flutter/material.dart';
import '../../../domain/entities/episode.dart';

class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E8B57), // Fondo verde
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: null, // Eliminamos el título aquí
        centerTitle: true,
        iconTheme:
            IconThemeData(color: Colors.white), // Ícono de volver en blanco
      ),
      body: Center(
        // Centrar el contenido
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Asumiré que los episodios no tienen una imagen, así que utilizaremos un contenedor circular como placeholder.
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: Color(0xFF003366), // Azul oscuro
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "E", // Representación simbólica para "Episode"
                    style: TextStyle(fontSize: 70, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 24), // Espacio aumentado para más separación
              Text('Name: ${episode.name}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 20), // Espacio añadido
              Text('Air Date: ${episode.airDate}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 20), // Espacio añadido
              Text('Episode: ${episode.episode}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
