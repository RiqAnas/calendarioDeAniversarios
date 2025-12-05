import 'package:flutter/material.dart';

class Colorsmap {
  static final Map<String, Color> colorMap = {
    'Vermelho': Colors.red,
    'Rosa': Colors.pink,
    'Rosa Claro': const Color.fromARGB(255, 248, 162, 191),
    'Roxo': Colors.purple,
    'Roxo Escuro': Colors.deepPurple,
    'Indigo': Colors.indigo,
    'Azul': Colors.blue,
    'Azul Claro': Colors.lightBlue,
    'Ciano': Colors.cyan,
    'Verde Água': Colors.teal,
    'Verde': Colors.green,
    'Verde Claro': Colors.lightGreen,
    'Limão': Colors.lime,
    'Amarelo': Colors.yellow,
    'Âmbar': Colors.amber,
    'Laranja': Colors.orange,
    'Laranja Escuro': Colors.deepOrange,
    'Marrom': Colors.brown,

    'Cinza': Colors.grey,
    'Cinza Azulado': Colors.blueGrey,
    'Preto': Colors.black,
    'Branco': Colors.white,
    'Sem Cor': Colors.transparent,
  };

  static Color getColor(String colorName) {
    final normalizedKey = colorName;
    return colorMap[normalizedKey] ?? Colors.transparent;
  }
}
