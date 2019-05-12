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
      onGenerateRoute: router.generator, // Use our Fluro routers for this app.
    ),
  );
}
