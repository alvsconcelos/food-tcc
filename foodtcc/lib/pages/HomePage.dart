import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:foodtcc/helpers.dart';
import 'package:foodtcc/pages/SingleProductPage.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/TaxTerm.dart';
import 'package:foodtcc/cardCarouselWithTitle.dart';
import 'package:foodtcc/sectionTitle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaxTerm> _taxTerms;
  List<Product> _allProducts;
  bool _contentLoaded = false;

  Future _getData() async {
    var _termsList = await getTaxonomyTerms();
    var _productsList = await getAllProducts();

    setState(() {
      _taxTerms = _termsList;
      _allProducts = _productsList;
      _contentLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Color(0xFFf5f7fa),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              elevation: 2,
              forceElevated: true,
              backgroundColor: Theme.of(context).accentColor,
              title: Text(
                'FoodIFPA',
                style: TextStyle(
                  color: Colors.white,
                  height: 1.2,
                  fontSize: 28,
                  fontFamily: 'Hind',
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.0,
                ),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {},
              ),
            ),
            SliverToBoxAdapter(
                child: _contentLoaded
                    ? Column(
                        children: <Widget>[
                          FeaturedProducts(_allProducts),
                          ProductList(_taxTerms, _allProducts),
                        ],
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height -
                            150, // The height of screen minus the appbar size
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class FeaturedProducts extends StatelessWidget {
  List<Product> _productsList;
  FeaturedProducts(this._productsList);

  @override
  Widget build(BuildContext context) {
    //List sort

    /* Sort products list by views count */
    _productsList.sort((a, b) => a.viewsCount.compareTo(b.viewsCount));

    /* Then, reverse it */
    _productsList = _productsList.reversed.toList();

    // End sorting

    final double _boxSize = MediaQuery.of(context).size.width - 50;
    final int _featuredProductsCount =
        min(_productsList.length, 4); // Set the featured products count (4)

    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 20),
      child: Column(
        children: <Widget>[
          SectionTitle(
            title: 'Destaques',
          ),
          Container(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _featuredProductsCount,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 15, right: _featuredProductsCount == (index + 1) ? 15 : 0), // Check if its the last element on the carousel, then if it is, adds a right padding.
                  child: GestureDetector(
                    onTap: () {
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            SingleProductPage(_productsList[index]),
                      );
                      Navigator.of(context).push(route);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: _boxSize,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/placeholder.png',
                              image: _productsList[index].featuredImage[0],
                              fit: BoxFit.cover,
                              height: 260,
                            ),
                          ),
                          Container(
                            height: 350.0,
                            width: _boxSize,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF2d3447).withOpacity(0.1),
                                  Color(0xFF1b1e44).withOpacity(0.8),
                                ],
                                stops: [0.0, 1.0],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _productsList[index].title,
                                  style: Theme.of(context).textTheme.headline,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'R\$ ${_productsList[index].price}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            decoration: _productsList[index]
                                                        .promoPrice !=
                                                    ''
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                      SizedBox(width: 5),
                                      _productsList[index].promoPrice != ''
                                          ? Text(
                                              'R\$ ${_productsList[index].promoPrice}',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                              ),
                                            )
                                          : SizedBox(),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, right: 5),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                      Text(
                                        _productsList[index]
                                            .viewsCount
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.2),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<TaxTerm> _taxTerms;
  final List<Product> _allProducts;

  ProductList(this._taxTerms, this._allProducts);

  @override
  Widget build(BuildContext context) {
    List<Widget> _carouselList = [];

    _taxTerms.forEach((term) {
      List<Product> _productsWithThisCategory = _allProducts
          .where((product) => product.categoryId == term.id)
          .toList();

      if (_productsWithThisCategory.length > 0) {
        _carouselList.add(
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CardCarouselWithTitle(
              cardCarouselTitle: term.name,
              cardCarouselData: _productsWithThisCategory,
            ),
          ),
        );
      }
    });

    return Column(children: _carouselList);
  }
}
