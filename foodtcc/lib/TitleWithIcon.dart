import 'package:flutter/material.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  TitleWithIcon(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            icon,
            color: Theme.of(context).accentColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
