import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/src/widgets/movi_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider
        .getPopulares(); //para que se mande a llamar el metodo por primera vez

    return Scaffold(
        appBar: AppBar(
          centerTitle: false, //para que el texto se vaya a un lado
          title: Text('Green Películas'),
          backgroundColor: Colors.green, //color de fondo
          actions: <Widget>[
            //los controles o acciones que tiene el appbar
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTajetas(), _footer(context)],
        ));
  }

  Widget _swiperTajetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCartelera(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          //se muestra mientras no se resuelve el future
          return Container(
              height: 200, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity, //para que ocupe todo el ancho
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1, //para tomar la config global
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MoviHorizontal(
                  peliculas: snapshot.data,
                  fucFinScroll: peliculasProvider
                      .getPopulares, //mandamos a traer mas peliculas
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
