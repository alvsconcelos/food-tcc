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
              expandedHeight: 350,
              flexibleSpace: Container(
                // width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: widget._selectedProduct.featuredImage[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF2d3447).withOpacity(0),
                            Color(0xFF1b1e44).withOpacity(0.2),
                            Color(0xFF1b1e44).withOpacity(0.6),
                          ],
                          stops: [0.0, 0.6, 1.0],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget._selectedProduct.title,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontFamily: "SF-Pro-Text-Regular",
                                color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'R\$ ${widget._selectedProduct.price}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      decoration:
                                          widget._selectedProduct.promoPrice !=
                                                  ''
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
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: ,
            // ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget._selectedProduct.description,
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RaisedButton(
                  color: Colors.redAccent.shade400,
                  child: Container(
                    child: Center(
                      child: Text("Pedir pelo Whatsapp", style: TextStyle(color: Colors.white, fontSize: 18,),),
                    ),
                    height: 60,
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
