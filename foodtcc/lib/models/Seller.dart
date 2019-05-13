import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Seller {
  final int id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String whatsapp;
  final String logo;
  // final Map<String, bool> paymentMethods;
  final bool isOpen;

  Seller({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.address,
    @required this.phone,
    @required this.whatsapp,
    @required this.logo,
    // @required this.paymentMethods,
    @required this.isOpen,
  });

  factory Seller.fromJson(Map<String, dynamic> jsonData) {
    var data = jsonData['cmb2']['_faseller_seller_data'];
    return Seller(
      id: jsonData['id'],
      name: data['_faseller_name'],
      description: data['_faseller_description'],
      address: data['_faseller_address'],
      phone: data['_faseller_phone'],
      whatsapp: data['_faseller_whatsapp'],
      logo: data['_faseller_logo'],
      isOpen: checkIfItsOpen(
        data['_faseller_open_hours'],
      ),
    );
  }
}

bool checkIfItsOpen(dynamic data) {
  DateFormat dateFormat = new DateFormat.Hm();

  final DateTime currentTime = DateTime.now();
  final int dayNum = currentTime.weekday - 1;
  final String openHour = data['${dayNum}_open'];
  final String closeHour = data['${dayNum}_close'];

  print(currentTime.day);

  DateTime openTime = dateFormat.parse(openHour);
  openTime = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    openTime.hour,
    openTime.minute,
  );

  DateTime closeTime = dateFormat.parse(closeHour);
  closeTime = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    closeTime.hour, 
    closeTime.minute,
  );

  if (currentTime.isAfter(openTime) && currentTime.isBefore(closeTime)) {
    return true;
  }

  return false;
}
