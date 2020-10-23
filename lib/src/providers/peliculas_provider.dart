import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //le ponemos un alias al paquete

import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = "a28723083abe7cf0ebd9f69fa3740ce3";
  String _url = "api.themoviedb.org";
  String _language = "es-MX";
  int _popularesPage = 1;

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
    _popularesPage++;
    //formamos el url para hacer la peticion
    print('# pagina:$_popularesPage');
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

    return resp;
  }
}
