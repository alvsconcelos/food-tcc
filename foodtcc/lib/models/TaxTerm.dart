import 'package:flutter/material.dart';

class TaxTerm {
  final int id;
  final String name;
  final String slug;
  final int count;

  TaxTerm({
    @required this.id,
    @required this.name,
    @required this.slug,
    @required this.count,
  });

  factory TaxTerm.fromJson(Map<String, dynamic> jsonData) {
    return TaxTerm(
      id: jsonData['id'],
      name: jsonData['name'],
      slug: jsonData['slug'],
      count: jsonData['count'],
    );
  }  
}
