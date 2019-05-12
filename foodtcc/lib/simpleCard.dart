import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

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
      padding: EdgeInsets.only(left: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              // Hero(
              //   tag: imageAdress,
              //   child: ,
              // ),
              Container(
                  width: 200,
                  height: 125,
                  // width: MediaQuery.of(context).size.width,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
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
                          fontWeight: FontWeight.w600,
                          fontFamily: "SF-Pro-Text-Regular",
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
          ),
        ),
      ),
    );
  }
}
