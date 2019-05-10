import 'package:flutter/material.dart';
import 'dart:math';
import 'data.dart';

class CardScrollWidget extends StatefulWidget {
  @override
  _CardScrollWidgetState createState() => _CardScrollWidgetState();
}

final double cardAspectRatio = 12.0 / 16.0;
final double widgetAspectRatio = cardAspectRatio * 1.2;

class _CardScrollWidgetState extends State<CardScrollWidget> {
  double currentPage = dados.length - 1.0;

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: dados.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    final dynamic cardData = dados;
    final double padding = 20.0;
    final double verticalInset = 20.0;

    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        double width = contraints.maxWidth;
        double height = contraints.maxHeight;

        double safeWidth = width - 2 * padding;
        double safeHeight = height - 2 * padding;

        double heightOfPrimaryCard = safeHeight;
        double widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        double primaryCardLeft = safeWidth - widthOfPrimaryCard;
        double horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < cardData.length; i++) {
          double delta = i - currentPage;
          bool isOnRight = delta > 0;

          double start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          Widget cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(cardData[i]['img'], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(cardData[i]['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontFamily: "SF-Pro-Text-Regular")),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, bottom: 12.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text("Read Later",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }

        return Stack(
          children: <Widget>[
            Stack(children: cardList),
            Positioned.fill(
              child: PageView.builder(
                itemCount: dados.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index) {
                  return Container();
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
