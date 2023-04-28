import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Descrizione.dart';
import 'myapp.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/Descrizione': (context) => Descrizione(),
      },
    ),
  );
}
