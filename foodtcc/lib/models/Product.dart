import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String price;
  final String promoPrice;
  final List<dynamic> featuredImage;
  final int categoryId;
  final int authorId;
  final int viewsCount;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    this.promoPrice = '0',
    this.featuredImage,
    @required this.categoryId,
    @required this.authorId,
    @required this.viewsCount,
  });

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    // var images = jsonData['cmb2']['_faproduct_product_data']['_faproduct_photos'].values.toList();
    // print(images[0]);
    return Product(
      id: jsonData['id'],
      title: jsonData['title']['rendered'],
      description: jsonData['cmb2']['_faproduct_product_data']['_faproduct_description'],
      price: jsonData['cmb2']['_faproduct_product_data']['_faproduct_price'],
      promoPrice: jsonData['cmb2']['_faproduct_product_data']['_faproduct_promo_price'],
      featuredImage: jsonData['cmb2']['_faproduct_product_data']['_faproduct_photos'].values.toList(),
      categoryId: jsonData['food_category'][0],
      authorId: jsonData['author'],
      viewsCount: treatViewsCount(jsonData['cmb2']['_faproduct_product_data']['_faproduct_views'])
    );
  }
}

int treatViewsCount(String actualCount) {
  if(actualCount.isEmpty || actualCount == '0') {
    return 0;
  }

  return int.parse(actualCount);
}
