import 'package:flutter/material.dart';
import 'package:foodtcc/pages/SplashScreen.dart';

void main() {
  runApp(
    MaterialApp(
        title: "Pai d'égua - Catálogo delivery",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.redAccent.shade400,
          textTheme: TextTheme(
            headline: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: 'Hind',
                color: Colors.white),
            title: TextStyle(
              color: Colors.grey.shade800,
              fontFamily: 'Hind',
              fontWeight: FontWeight.bold,
              fontSize: 26,
              letterSpacing: -0.5,
            ),
            body1: TextStyle(
              color: Colors.grey.shade900,
              fontFamily: 'Open Sans',
              fontSize: 16,
            ),
          ),
        )),
  );
}
