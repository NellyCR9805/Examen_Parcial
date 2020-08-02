import 'package:flutter/material.dart';
import 'package:pc/pages/alumno_page.dart';
import 'package:pc/pages/lista_pagos.dart';
import 'package:pc/pages/login_page.dart';
import 'package:pc/pages/olvd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Módulo de Consulta',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      initialRoute: " / ",
      routes: {
                  '/alumnopage': (context) =>AlumnoPage(),
                  '/olvdpage': (context) =>ForgotPass(),
                  '/loginpage': (context) =>LoginPage(),
                  '/listapage': (context) =>ListaPage(),


      },
    );
  }
}

