import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';

import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

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

    return FutureBuilder(      
      future: peliculasProvider.getEnCartelera(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
         
         if(snapshot.hasData){
            return CardSwiper( peliculas: snapshot.data);
         }else{
           //se muestra mientras no se resuelve el future
           return Container(
             height: 400, 
             child: Center(child: CircularProgressIndicator())
            );
         }
         
         
      }
    );

   
    
  }
}