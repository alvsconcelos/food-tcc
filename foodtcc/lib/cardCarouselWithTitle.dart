import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodtcc/pages/SingleProductPage.dart';
import 'sectionTitle.dart';
import 'simpleCard.dart';
import 'package:foodtcc/helpers.dart';
import 'package:foodtcc/models/Product.dart';

class CardCarouselWithTitle extends StatelessWidget {
  final String cardCarouselTitle;
  final List<Product> cardCarouselData;

  CardCarouselWithTitle({this.cardCarouselTitle, this.cardCarouselData});

  @override
  Widget build(BuildContext context) {
    final double containerSize = 220;

    return Column(
      children: <Widget>[
        SectionTitle(title: cardCarouselTitle),
        Container(
          height: containerSize,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cardCarouselData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: index == (cardCarouselData.length - 1)
                    ? EdgeInsets.only(
                        right: 20,
                      )
                    : EdgeInsets.only(
                        right:
                            0), // Check if is on the end of the list, then it adds a paddding.
                child: GestureDetector(
                  onTap: () {
                    var route = new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SingleProductPage(cardCarouselData[index]),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: SimpleCard(
                    title: cardCarouselData[index].title,
                    imageAdress: cardCarouselData[index].featuredImage[0],
                    price: cardCarouselData[index].price,
                    promoPrice: cardCarouselData[index].promoPrice,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}

// class CardCarouselWithTitle2 extends StatefulWidget {
//   @override
//   _CardCarouselWithTitle2State createState() => _CardCarouselWithTitle2State();

//   final String cardCarouselTitle;

//   CardCarouselWithTitle2({this.cardCarouselTitle});
// }

// class _CardCarouselWithTitle2State extends State<CardCarouselWithTitle2> {
//   List<Product> cardCarouselData;

//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   Future _getData() async {
//     var data = await getAllProducts();

//     setState(() {
//       cardCarouselData = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double containerSize = 220;

//     return Column(
//       children: <Widget>[
//         SectionTitle(title: widget.cardCarouselTitle),
//         cardCarouselData == null
//             ? Container(
//                 height: containerSize,
//                 child: Center(
//                   child: CupertinoActivityIndicator(),
//                 ),
//               )
//             : Container(
//                 height: containerSize,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: cardCarouselData.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       padding: index == (cardCarouselData.length - 1)
//                           ? EdgeInsets.only(right: 20)
//                           : EdgeInsets.only(
//                               right:
//                                   0), // Check if is on the end of the list, then it adds a paddding.
//                       child: SimpleCard(
//                           title: cardCarouselData[index].title,
//                           imageAdress: cardCarouselData[index].featuredImage[0],
//                           price: cardCarouselData[index].price,
//                           promoPrice: cardCarouselData[index].promoPrice,
//                         ),
//                     );
//                   },
//                 ),
//               ),
//         SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }
// }
