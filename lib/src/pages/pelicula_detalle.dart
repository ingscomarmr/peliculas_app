import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //para obtener la pelicula que se le mando desde los argumentos
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[_crearAppBar(pelicula)],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo,
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getUrlImgBackground()),
          placeholder: AssetImage('assets/img/loading.gif'),
          /*fadeInDuration: Duration(microseconds: 150),*/
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
