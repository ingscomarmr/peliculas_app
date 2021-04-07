import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = "";
  final PeliculasProvider peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Batman',
    'Ironman 1',
    'Ironman 2',
    'Ironman 3',
    'Sazam!',
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // LAS ACCIONES QUE SE MUESTRAN EN EL SEARCH BAR
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('Limpiar query = $query');
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ICONO QUE SE MUESTRA A LA IZQUIERDA
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Dio clic al Leading');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // CREAR RESULTADOS QUE VAMOS A MOSTRAR
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // SUGERENCIAS QUE SE MUESTRAN CUANDO ESCRIBE

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPerlicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          try {
            return ListView(
              children: peliculas.map((p) {
                print(p.getUrlImg());
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(p.getUrlImgBackground()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(p.title),
                  subtitle: Text(p.originalTitle),
                );
              }).toList(),
            );
          } catch (ex) {
            print(ex);
          }
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

    /* ejemplo
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i].toString()),
          onTap: () {
            seleccion = listaSugerida[i];
            showResults(context); //para construir el resultado
          },
        );
      },
    );*/
  }
}
