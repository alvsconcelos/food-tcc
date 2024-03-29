import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SimpleCard extends StatelessWidget {
  final String title;
  final String imageAdress;
  final String price;
  final String promoPrice;

  SimpleCard({this.title, this.imageAdress, this.price, this.promoPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 15),
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 120,
                // width: MediaQuery.of(context).size.width,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: imageAdress,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Open Sans",
                        ),
                        softWrap: true,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'R\$ ${price}',
                          style: TextStyle(
                              color: Colors.black,
                              decoration: promoPrice != ''
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        SizedBox(width: 5),
                        promoPrice != ''
                            ? Text(
                                'R\$ ${promoPrice}',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
