import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/TaxTerm.dart';
import 'package:foodtcc/cardCarouselWithTitle.dart';
import 'package:foodtcc/data.dart';
import 'package:foodtcc/cardScroll.dart';
import 'package:foodtcc/sectionTitle.dart';
import 'package:foodtcc/helpers.dart';

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
        _carouselList.add(CardCarouselWithTitle(
          cardCarouselTitle: term.name,
          cardCarouselData: _productsWithThisCategory,
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
