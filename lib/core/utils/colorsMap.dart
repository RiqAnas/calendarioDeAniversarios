import 'package:flutter/material.dart';

class Colorsmap {
  static final Map<String, Color> colorMap = {
    'vermelho': Colors.red,
    'rosa': Colors.pink,
    'roxo': Colors.purple,
    'roxoescuro': Colors.deepPurple,
    'indigo': Colors.indigo,
    'azul': Colors.blue,
    'azulclaro': Colors.lightBlue,
    'ciano': Colors.cyan,
    'verdeagua': Colors.teal,
    'verde': Colors.green,
    'verdeclaro': Colors.lightGreen,
    'limao': Colors.lime,
    'amarelo': Colors.yellow,
    'ambar': Colors.amber,
    'laranja': Colors.orange,
    'laranjaescuro': Colors.deepOrange,
    'marrom': Colors.brown,

    'cinza': Colors.grey,
    'cinzaazulado': Colors.blueGrey,
    'preto': Colors.black,
    'branco': Colors.white,
    'semcor': Colors.transparent,

    'rosaclaro': const Color.fromARGB(255, 248, 162, 191),
  };

  static Color getColor(String colorName) {
    final normalizedKey = colorName
        .replaceAll(RegExp(r'\s+'), '')
        .toLowerCase();
    return colorMap[normalizedKey] ?? Colors.transparent;
  }
}
