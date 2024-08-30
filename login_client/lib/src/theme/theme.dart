import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(254, 188, 69, 4), 
      secondary: Colors.amber,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.amber[800],
      titleTextStyle: const TextStyle(color: Color.fromARGB(255, 148, 38, 38), fontSize: 20),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber),
      ),
      labelStyle: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
      floatingLabelStyle: TextStyle(color: Colors.amber),
      hintStyle: TextStyle(color: Colors.grey),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 81, 203, 112), 
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.blue),
      displayMedium: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      bodyLarge: TextStyle(fontSize: 14.0, color: Color.fromARGB(221, 224, 15, 15)),
    ),
  );
}

