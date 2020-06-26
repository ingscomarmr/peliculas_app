import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  
  final List<dynamic> peliculas;

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
            child: Image.network("https://image.tmdb.org/t/p/w500/4N55tgxDW0RRATyrZHbx0q9HUKv.jpg",
            fit: BoxFit.cover),
          );
        },
        //pagination: SwiperPagination(), //para mostrar los puntitos
        //control: SwiperControl(), //para mostrar los controles de los lados
      ),
    );
  }
}