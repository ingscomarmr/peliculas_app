import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //para obtener la pelicula que se le mando desde los argumentos
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Pelicula'),
      ),
      body: Center(
        child: Text('Detalles pelicula: ${pelicula.title}'),
      ),
    );
  }
}
