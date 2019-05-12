import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:foodtcc/pages/HomePage.dart';
import 'package:foodtcc/pages/SingleProductPage.dart';

void main() {
  Router router = Router();

  router.define(
    '/home',
    handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    }),
  );

  // router.define(
  //   '/singleproduct/',
  //   handler: Handler(
  //       handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //     return SingleProductPage();
  //   }),
  // );

  runApp(
    MaterialApp(
        title: 'foodIfpa',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute:
            router.generator, // Use our Fluro routers for this app.
        theme: ThemeData(
          // Define the default Brightness and Colors

          // Define the default Font Family
          // fontFamily: 'Roboto',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 26,
              letterSpacing: -0.5,
            ),
            body1: TextStyle(fontSize: 16.0),
          ),
        )),
  );
}
