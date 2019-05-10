import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final String title;
  final String imageAdress;

  SimpleCard({this.title, this.imageAdress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imageAdress),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: "SF-Pro-Text-Regular"),
          )
        ],
      ),
    );
  }
}
