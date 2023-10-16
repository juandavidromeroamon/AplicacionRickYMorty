import 'package:flutter/material.dart';
import '../../../domain/entities/location.dart';

class LocationDetailPage extends StatelessWidget {
  final Location location;

  LocationDetailPage({required this.location});

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
              Container(
                width: 200.0, // Tamaño aumentado
                height: 200.0, // Tamaño aumentado
                decoration: BoxDecoration(
                  color: Color(0xFF003366), // Azul oscuro
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 24), // Espacio aumentado para más separación
              Text('Name: ${location.name}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 20), // Espacio añadido
              Text('Type: ${location.type}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 20), // Espacio añadido
              Text('Dimension: ${location.dimension}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 20), // Espacio añadido
              Text('Created: ${location.created}',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 24), // Espacio aumentado para más separación
              Text(
                  'Number of Residents: ${location.residents.length}', // Solo mostramos la cantidad de residentes
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
