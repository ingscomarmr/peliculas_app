import 'dart:convert';
import 'package:http/http.dart' as http; //le ponemos un alias al paquete

import 'package:peliculas_app/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apiKey      = "a28723083abe7cf0ebd9f69fa3740ce3";
  String _url         = "api.themoviedb.org";
  String _language    = "es-MX";


  Future<List<Pelicula>> getEnCartelera() async{

    //formamos el url para hacer la peticion
    final url = Uri.https(
      _url, //url, ya te agrega https
      '3/movie/now_playing', //la ruta del api rest
      { //un map con el nombre de los parametros a enviar y sus valores
        'api_key'   :_apiKey, 
        'language'  : _language      
      }
    );

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body); //decodificamos la respuesta en string
    
    final peliculas = Peliculas.fromJsonList(decodeData['results']); //pasa el json a el model

    //print(peliculas.items[0].title);

    return peliculas.items; //retona las peliculas
  }

}