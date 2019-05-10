import 'package:flutter/material.dart';
import 'sectionTitle.dart';
import 'simpleCard.dart';

class CardCarouselWithTitle extends StatelessWidget {
  final String cardCarouselTitle;
  final dynamic cardCarouselData;

  CardCarouselWithTitle({this.cardCarouselTitle, this.cardCarouselData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionTitle(title: cardCarouselTitle),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardCarouselData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: index == (cardCarouselData.length - 1) ? EdgeInsets.only(right: 20) : EdgeInsets.only(right: 0), // Check if is on the end of the list, then it adds a paddding.
                child: SimpleCard(
                  title: cardCarouselData[index]['title'],
                  imageAdress: cardCarouselData[index]['img'],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
