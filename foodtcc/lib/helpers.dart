import 'dart:convert';
import 'package:foodtcc/models/Seller.dart';
import 'package:http/http.dart' as http;
import 'package:foodtcc/models/Product.dart';
import 'package:foodtcc/models/TaxTerm.dart';

const String BASE_URL = 'https://foodapp.underbits.com.br/wp-json';

Future<List<Product>> getAllProducts() async {
  final response = await http.get('$BASE_URL/wp/v2/food_products');
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

Future<List<TaxTerm>> getTaxonomyTerms() async {
  final response = await http.get('$BASE_URL/wp/v2/food_category');
  if (response.statusCode == 200) {
    final List<TaxTerm> fetchedTermsList = [];
    var termsListData = json.decode(response.body);
    termsListData.forEach((dynamic productData) {
      if(productData['count'] >= 1) fetchedTermsList.add(TaxTerm.fromJson(productData));
    });
    return fetchedTermsList;
  } else {
    throw Exception('Failed to load taxonomy terms');
  }
}

Future<List<Product>> getProductsByCategory(int taxID) async {
  final response = await http.get('$BASE_URL/wp/v2/food_products?food_category=${taxID}');

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

Future<Seller> getSellerData(int authorId) async {
  final response = await http.get('$BASE_URL/wp/v2/users/${authorId}');

  if (response.statusCode == 200) {
    Seller fetchedSeller = Seller.fromJson(json.decode(response.body));
    return fetchedSeller;
  } else {
    throw Exception('Failed to load products');
  }
}

Future<void> registerViewsForProduct(int postId) async {
  final response = await http.get('$BASE_URL/food-api/register-views/$postId');
  if (response.statusCode == 200) {
    print('View added.');
  } else {
    print('View not added.');
  }  
}
