import 'package:flutter/material.dart';

import 'package:peliculas_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  //String API_Key = "a28723083abe7cf0ebd9f69fa3740ce3";//(v3 auth)
  //String Example_API_Request = "https://api.themoviedb.org/3/movie/550?api_key=a28723083abe7cf0ebd9f69fa3740ce3";//(v3 auth)
  //String API_Read_Access_Token  = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMjg3MjMwODNhYmU3Y2YwZWJkOWY2OWZhMzc0MGNlMyIsInN1YiI6IjVlZTk5YjkzZmRjMTQ2MDAzNGU1Mjk1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b0t66S4UueqHDVINNoGOcwxJFNCYUUEAfNBE4pQuzbY";//(v4 auth)
  //https://image.tmdb.org/t/p/w500/4N55tgxDW0RRATyrZHbx0q9HUKv.jpg

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'     : (BuildContext context) => HomePage(),
      },
    );
  }
}