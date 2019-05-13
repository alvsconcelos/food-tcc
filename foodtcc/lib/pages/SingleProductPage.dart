import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodtcc/TitleWithIcon.dart';
import 'package:foodtcc/helpers.dart';
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/Seller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleProductPage extends StatefulWidget {
  final Product _selectedProduct;

  SingleProductPage(this._selectedProduct);

  @override
  _SingleProductPageState createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  Seller _productSeller;

  Future _getSeller() async {
    var _seller = await getSellerData(widget._selectedProduct.authorId);

    setState(() {
      _productSeller = _seller;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSeller();
  }

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
                            Color(0xFF2d3447).withOpacity(0.8),
                            Color(0xFF1b1e44).withOpacity(0),
                            Color(0xFF1b1e44).withOpacity(0.9),
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
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
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
                padding: EdgeInsets.fromLTRB(20, 60, 20, 40),
                child: Text(
                  widget._selectedProduct.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: _productSeller == null
                    ? CupertinoActivityIndicator()
                    : _buildSellerData(_productSeller),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSellerData(Seller _productSeller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: TitleWithIcon(
              'Dados do vendedor',
              Icons.store,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: _productSeller.isOpen
                          ? Colors.greenAccent.shade700
                          : Colors.redAccent.shade200,
                    ),
                    child: Column(
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/placeholder.png',
                          image: _productSeller.logo,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 5,
                          ),
                          child: Center(
                            child: Text(
                                _productSeller.isOpen
                                    ? 'ABERTO AGORA'
                                    : 'FECHADO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                softWrap: true),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _productSeller.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Hind",
                      ),
                      softWrap: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.place,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _productSeller.address,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.phone,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _productSeller.phone,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 30,
            ),
            child: RaisedButton(
              color: Colors.redAccent.shade400,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Pedir pelo Whatsapp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                height: 60,
              ),
              onPressed: () {
                return whatsAppOpen(
                  _productSeller.whatsapp,
                  widget._selectedProduct.title,
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void whatsAppOpen(String telNum, String productName) async {

    final String url = Uri.encodeFull('https://api.whatsapp.com/send?phone=$telNum&text=Olá, quero pedir $productName');

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
