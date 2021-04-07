import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //le ponemos un alias al paquete

import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/models/actor_model.dart';

class PeliculasProvider {
  String _apiKey = "a28723083abe7cf0ebd9f69fa3740ce3";
  String _url = "api.themoviedb.org";
  String _language = "es-MX";
  int _popularesPage = 1;
  bool _cargandoPopulares = false;

  List<Pelicula> _popularesList = new List();
  //meter Stream y patron block
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();
  //metodo forzoso para introducir peluculas al stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  //metodo forzoso para obtener las peliculas del stream
  Stream get popularesStream => _popularesStreamController.stream;
  //metodo forzoso para cerrar el stream
  void disposeStreams() {
    _popularesStreamController?.close();
  }

  //para procesar el mismo resultado de la url peliculas
  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData =
        json.decode(resp.body); //decodificamos la respuesta en string

    final peliculas =
        Peliculas.fromJsonList(decodeData['results']); //pasa el json a el model

    //print(peliculas.items[0].title);

    return peliculas.items; //retona las peliculas
  }

  Future<List<Pelicula>> getEnCartelera() async {
    //formamos el url para hacer la peticion
    final url = Uri.https(
        _url, //url, ya te agrega https
        '3/movie/now_playing', //la ruta del api rest
        {
          //un map con el nombre de los parametros a enviar y sus valores
          'api_key': _apiKey,
          'language': _language
        });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargandoPopulares) {
      return []; //si esta cargando que retorne vacio por mientras
    }

    _cargandoPopulares = true; //que indique que va empezar a cargar

    _popularesPage++;
    //formamos el url para hacer la peticion
    print('Cargando # pagina:$_popularesPage');
    final url = Uri.https(
        _url, //url, ya te agrega https
        '3/movie/popular', //la ruta del api rest
        {
          //un map con el nombre de los parametros a enviar y sus valores
          'api_key': _apiKey,
          'language': _language,
          'page': _popularesPage.toString()
        });

    final resp = await _procesarRespuesta(url);

    //meter las peluculas al stream
    _popularesList.addAll(resp);
    popularesSink(_popularesList); //se meten las peliculas al stream

    _cargandoPopulares = false; //para que ya liber el cargando
    return resp;
  }

  Future<List<Actor>> getActores(String peliculaId) async {
    print("Obtener Creditos de Pelicula id:" + peliculaId);
    final url = Uri.https(
        _url, //url, ya te agrega https
        '3/movie/$peliculaId/credits', //la ruta del api rest
        {
          //un map con el nombre de los parametros a enviar y sus valores
          'api_key': _apiKey,
          'language': _language
        });

    final resp = await http.get(url);

    final decodeData =
        json.decode(resp.body); //decodificamos la respuesta en string

    print(decodeData.toString());
    final cast =
        Cast.fromJsonList(decodeData['cast']); //pasa el json a el model

    //print(peliculas.items[0].title);

    return cast.actores; //retona las peliculas
  }

  Future<List<Pelicula>> buscarPerlicula(String query) async {
    //formamos el url para hacer la peticion
    final url = Uri.https(
        _url, //url, ya te agrega https
        '3/search/movie', //la ruta del api rest
        {
          //un map con el nombre de los parametros a enviar y sus valores
          'api_key': _apiKey,
          'language': _language,
          'query': query
        });

    return await _procesarRespuesta(url);
  }
}
