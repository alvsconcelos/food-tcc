import 'package:flutter/material.dart';
import 'package:foodtcc/cardCarouselWithTitle.dart';
import 'customIcons.dart';
import 'data.dart';
import 'cardScroll.dart';
import 'simpleCard.dart';
import 'sectionTitle.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _MyAppState extends State<MyApp> {
  var currentPage = dados.length - 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('SliverAppBar'),
              backgroundColor: Colors.transparent,
              expandedHeight: 90,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.0,
                ),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {},
                )
              ],
            ),
            SliverToBoxAdapter(
              child: SectionTitle(title: 'Destaques'),
            ),
            SliverToBoxAdapter(
              child: CardScrollWidget(),
            ),
            SliverToBoxAdapter(
              child: CardCarouselWithTitle(
                cardCarouselTitle: 'Pizzarias',
                cardCarouselData: dados,
              ),
            ),
            SliverToBoxAdapter(
              child: CardCarouselWithTitle(
                cardCarouselTitle: 'Hamburguerias',
                cardCarouselData: dados,
              ),
            ),
            SliverToBoxAdapter(
              child: CardCarouselWithTitle(
                cardCarouselTitle: 'Restaurantes',
                cardCarouselData: dados,
              ),
            ),
            SliverToBoxAdapter(
              child: CardCarouselWithTitle(
                cardCarouselTitle: 'Pizzarias',
                cardCarouselData: dados,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
