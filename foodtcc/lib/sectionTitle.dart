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
      padding: EdgeInsets.only(left: 20, right: 20,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleSize,
                fontFamily: "Calibre-Semibold",
                letterSpacing: -0.5,
              )),
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
