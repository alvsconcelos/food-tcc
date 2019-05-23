import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodtcc/pages/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  void startDelay() {
    _timer = new Timer(const Duration(seconds: 1), () {
      var route = new MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      );
      Navigator.of(context).pushReplacement(route);
    });
  }

  @override
  void initState() {
    super.initState();
    startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Center(
        child: Image.asset(
          'assets/logo_splash.png',
          width: 200,
        ),
      ),
    );
  }
}
