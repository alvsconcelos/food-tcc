import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/TaxTerm.dart';
import 'package:http/http.dart' as http;

import 'package:foodtcc/cardCarouselWithTitle.dart';
import 'data.dart';
import 'cardScroll.dart';
import 'sectionTitle.dart';
import 'package:foodtcc/helpers.dart';

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
              child: SectionTitle(
                title: 'Destaques',
              ),
            ),
            SliverToBoxAdapter(
              child: CardScrollWidget(),
            ),
            SliverToBoxAdapter(
              child: ProductList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<TaxTerm> taxTerms;
  List<Product> allProducts;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    var termsList = await getTaxonomyTerms();
    var productsList = await getAllProducts();

    setState(() {
      allProducts = productsList;
      taxTerms = termsList;
    });
  }

  Widget buildProductList() {
      List<Widget> carouselList= [];

      taxTerms.forEach((term) {
        carouselList.add(
          CardCarouselWithTitle(cardCarouselTitle: term.name, cardCarouselData: allProducts,)
        );
      });

      return Column(children: carouselList);
  }

  @override
  Widget build(BuildContext context) { 
    return taxTerms == null
        ? Center(heightFactor: 9, child: CupertinoActivityIndicator(),)
        : buildProductList();
  }
}
