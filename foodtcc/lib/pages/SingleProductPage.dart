import 'package:flutter/material.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleProductPage extends StatefulWidget {
  final Product _selectedProduct;

  SingleProductPage(this._selectedProduct);

  @override
  _SingleProductPageState createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Detalhes do produto'),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget._selectedProduct.featuredImage[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget._selectedProduct.title,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget._selectedProduct.description,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'R\$ ${widget._selectedProduct.price}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              decoration:
                                  widget._selectedProduct.promoPrice != ''
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                        ),
                        SizedBox(width: 5),
                        widget._selectedProduct.promoPrice != ''
                            ? Text(
                                'R\$ ${widget._selectedProduct.promoPrice}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18,  
                                ),
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
