import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {

    //uso de mediaquery para mejorar los tamañaos
    final _screenSize = MediaQuery.of(context).size;
    

    return Container(
      padding: EdgeInsets.only(top:10.0),     
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7, //para poder ajustar el swiper a lo ancho
        itemHeight: _screenSize.height * 0.5,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'), //poner una img mientras se carga
              image: NetworkImage(peliculas[index].getUrlImg()), //para obtener la img
              fit: BoxFit.cover, //para adaptar la imagen y se vea redonda
            ),
          );
        },
        //pagination: SwiperPagination(), //para mostrar los puntitos
        //control: SwiperControl(), //para mostrar los controles de los lados
      ),
    );
  }
}