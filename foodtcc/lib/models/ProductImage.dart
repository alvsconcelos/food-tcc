import 'package:flutter/material.dart';

class ProductImage {
  final String id;
  final String address;

  ProductImage({
    @required this.id,
    @required this.address,
  });

  factory ProductImage.fromJson(Map<String, dynamic> jsonData) {
    return ProductImage(
      id: jsonData.keys.first.toString(),
      address: jsonData['name'],
    );
  }  

  factory ProductImage.fromList() {
    
  }
}
