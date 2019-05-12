import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/TaxTerm.dart';
import 'package:foodtcc/cardCarouselWithTitle.dart';
import 'package:foodtcc/data.dart';
import 'package:foodtcc/cardScroll.dart';
import 'package:foodtcc/sectionTitle.dart';
import 'package:foodtcc/helpers.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final double cardAspectRatio = 12.0 / 16.0;
final double widgetAspectRatio = cardAspectRatio * 1.2;

class _HomePageState extends State<HomePage> {
  double currentPage = dados.length - 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Color(0xFFf5f7fa),
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text(
                'SliverAppBar',
                style: TextStyle(color: Colors.redAccent, fontSize: 22),
              ),
              centerTitle: true,
              expandedHeight: 80,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey,
                  size: 30.0,
                ),
                padding: EdgeInsets.only(left: 10),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
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
              child: FeaturedProducts(),
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
    var _termsList = await getTaxonomyTerms();
    var _productsList = await getAllProducts();

    setState(() {
      allProducts = _productsList;
      taxTerms = _termsList;
    });
  }

  Widget buildProductList() {
    List<Widget> _carouselList = [];

    taxTerms.forEach((term) {
      List<Product> _productsWithThisCategory = allProducts
          .where((product) => product.categoryId == term.id)
          .toList();

      if (_productsWithThisCategory.length > 0) {
        _carouselList.add(Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: CardCarouselWithTitle(
            cardCarouselTitle: term.name,
            cardCarouselData: _productsWithThisCategory,
          ),
        ));
      }
    });

    return Column(children: _carouselList);
  }

  @override
  Widget build(BuildContext context) {
    return taxTerms == null
        ? Center(
            heightFactor: 9,
            child: CupertinoActivityIndicator(),
          )
        : buildProductList();
  }
}

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    final double boxSize = MediaQuery.of(context).size.width - 50;

    return Container(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dados.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 15),
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: boxSize,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image:
                          'https://foodapp.underbits.com.br/wp-content/uploads/2019/05/photo-1501777814630-33bc4a3c3ee7.jpg',
                      fit: BoxFit.cover,
                      height: 260,
                    ),
                  ),
                  Container(
                    height: 350.0,
                    width: boxSize,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Título da carta',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                fontFamily: "SF-Pro-Text-Regular",
                                color: Colors.white),
                            softWrap: true,
                          )
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
