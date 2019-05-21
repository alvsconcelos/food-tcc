import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:foodtcc/pages/HomePage.dart';
import 'package:foodtcc/pages/SingleProductPage.dart';
import 'package:foodtcc/pages/SplashScreen.dart';

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
        // home: HomePage(),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute:
            router.generator, // Use our Fluro routers for this app.
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
