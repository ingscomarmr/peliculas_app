import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // LAS ACCIONES QUE SE MUESTRAN EN EL SEARCH BAR
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('Limpiar query = $query');
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // ICONO QUE SE MUESTRA A LA IZQUIERDA
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        print('Dio clic al Leading');
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // CREAR RESULTADOS QUE VAMOS A MOSTRAR
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // SUGERENCIAS QUE SE MUESTRAN CUANDO ESCRIBE
    return Container();
  }
}
