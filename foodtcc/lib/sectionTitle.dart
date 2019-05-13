import 'package:flutter/material.dart';
import 'customIcons.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double titleSize;
  final bool hasOptions;

  SectionTitle({this.title, this.titleSize = 38, this.hasOptions = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: Theme.of(context).textTheme.title),
          hasOptions
              ? IconButton(
                  icon: Icon(
                    CustomIcons.option,
                    size: 12.0,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              : Container()
        ],
      ),
    );
  }
}
