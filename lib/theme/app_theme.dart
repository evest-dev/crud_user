import 'package:flutter/material.dart';

const colorList = [
  Colors.blue,
  Colors.blueAccent,
  Colors.teal,
  Colors.greenAccent,
  Colors.red
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0, 'Selected color debe ser mayor a 0'),
        assert(selectedColor < colorList.length, 'Selected color debe ser menor o igual a ${colorList.length -1}');
    

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList [selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    )
  );
}
