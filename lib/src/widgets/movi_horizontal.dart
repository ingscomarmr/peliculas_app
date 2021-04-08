import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class MoviHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function fucFinScroll; //funcion que se manda a llamar desde fuera

  MoviHorizontal({@required this.peliculas, @required this.fucFinScroll});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController = PageController(
        initialPage: 1, viewportFraction: 0.3); //para controlar el scroll

    _pageController.addListener(() {
      //para que este leyendo y ejecute la funcion callback
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        fucFinScroll();
      }
    });

    return Container(
      height: _screenSize.width * 0.6,
      child: PageView.builder(
        //ayuda a gastar menos memoria, porque si trae 1000 todo se renderiza
        pageSnapping: false,
        controller: _pageController,
        //children: _targetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _createTarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _createTarjeta(BuildContext context, Pelicula pe) {
    pe.heroId = pe.id.toString() + '-tarjeta';

    final Widget tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        //para acomodarlas en forma lineal
        children: <Widget>[
          Hero(
            tag: pe.heroId,
            child: ClipRRect(
              //para hacer redondas las img
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pe.getUrlImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: 140.0,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            pe.title,
            overflow: TextOverflow.ellipsis, //para que el texto no se desborde
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      //para gestionar el on tab
      child: tarjeta, //le pasamos la tarjeta
      onTap: () {
        print('Dio tab en pelicula ${pe.title}');
        Navigator.pushNamed(context, 'detalles',
            arguments: pe); //en arguments mandamos el objeto de pelicula
      },
    );
  }

/*
  List<Widget> _targetas(BuildContext context) {
    return peliculas.map((pe) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          //para acomodarlas en forma lineal
          children: <Widget>[
            ClipRRect(
              //para hacer redondas las img
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pe.getUrlImg()),
                placeholder: AssetImage('assets/img/loading.gif'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              pe.title,
              overflow:
                  TextOverflow.ellipsis, //para que el texto no se desborde
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
  */

}
