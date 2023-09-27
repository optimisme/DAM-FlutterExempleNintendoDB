import 'package:flutter/material.dart';

class LayoutPersonatge extends StatelessWidget {
  final dynamic itemData;

  // Relacionar els colors amb el text que els defineix
  final Map<String, Color> colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'orange': Colors.orange,
    'brown': Colors.brown,
    'grey': Colors.grey,
  };

  // Constructor
  LayoutPersonatge({Key? key, required this.itemData}) : super(key: key);

  // Retornar un 'Color' a partir del text, fent servir el mapa de colors anterior
  Color getColorFromString(String colorString) {
    return colorMap[colorString.toLowerCase()] ?? Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ocupar la meitat superior de l'espai amb la imatge
          SizedBox(
            width: MediaQuery.of(context).size.width * 100.0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/images/${itemData["imatge"]}',
              fit: BoxFit.contain,
            ),
          ),
          // Ocupar la meitat inferior de l'espai amb els textos
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${itemData['nom']}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 10, 
                  height: 10, 
                  color: getColorFromString(itemData['color']), 
                ),
                const SizedBox(height: 10),
                Text(itemData['nom_del_videojoc']),
              ],
            ),
          ),
        ],
      ),
    );
  }
}