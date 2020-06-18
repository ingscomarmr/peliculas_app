import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:peliculas_app/src/providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false, //para que el texto se vaya a un lado
        title: Text('Green Películas'),
        backgroundColor: Colors.green, //color de fondo
        actions: <Widget>[ //los controles o acciones que tiene el appbar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _swiperTajetas()
        ],
      )
    );
  }

  Widget _swiperTajetas() {

    final peliProvider = PeliculasProvider();
    peliProvider.getEnCartelera();

    return Container(
      width: double.infinity,
      height: 300.0,
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 250.0,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index){
          return Image.network("https://image.tmdb.org/t/p/w500/4N55tgxDW0RRATyrZHbx0q9HUKv.jpg",
          fit: BoxFit.fill);
        },
        //pagination: SwiperPagination(), //para mostrar los puntitos
        //control: SwiperControl(), //para mostrar los controles de los lados
      ),
    );
  }
}