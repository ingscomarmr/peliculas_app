import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class MoviHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;

  MoviHorizontal({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.width * 0.6,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _targetas(context),
      ),
    
    );

  }

  List<Widget> _targetas(BuildContext context){
    return peliculas.map((pe){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column( //para acomodarlas en forma lineal
          children: <Widget>[
            ClipRRect( //para hacer redondas las img
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pe.getUrlImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(pe.title,            
              overflow: TextOverflow.ellipsis, //para que el texto no se desborde
              style: Theme.of(context).textTheme.caption,
            
            )
          ],
        ),
      );

    }).toList();
  }




}