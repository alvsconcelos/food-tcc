import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodtcc/models/Product.dart';

const String BASE_URL = 'https://foodapp.underbits.com.br/wp-json/wp/v2';

Future<List<Product>> getAllProducts() async {
  final response = await http.get('${BASE_URL}/food_products');
  if (response.statusCode == 200) {
    final List<Product> fetchedProductList = [];
    var productListData = json.decode(response.body);
    productListData.forEach((dynamic productData) {
      fetchedProductList.add(Product.fromJson(productData));
    });
    return fetchedProductList;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<List<Product>> getProductsByCategory(int taxID) async {
  final response = await http.get('${BASE_URL}/food_products?food_category=${taxID}');

  if (response.statusCode == 200) {
    final List<Product> fetchedProductList = [];
    var productListData = json.decode(response.body);
    productListData.forEach((dynamic productData) {
      fetchedProductList.add(Product.fromJson(productData));
    });
    return fetchedProductList;
  } else {
    throw Exception('Failed to load products');
  }
}
