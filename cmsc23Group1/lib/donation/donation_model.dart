// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';

class Donation {
  String? id;
  List<String>? category;
  bool? isForPickup;
  Double? weight;
  String? imageUrl;
  DateTime? pickupDropoffTime;
  List<String>? addressesForPickup;
  String? contactNumber;
  String? qrCode;
  String? status;

  Donation({
    this.id,
    required this.category,
    required this.isForPickup,
    required this.weight,
    this.imageUrl,
    this.addressesForPickup,
    required this.contactNumber,
    required this.pickupDropoffTime,
    required this.status,
    this.qrCode
  });

  Donation.emptyDonation() {
    category = null;
    category = null;
    isForPickup = null;
    weight = null;
    imageUrl = null;
    addressesForPickup = null;
    contactNumber = null;
    pickupDropoffTime = null;
    status = null;
  }

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      category: json['category'],
      isForPickup: json['isForPickup'],
      weight: json['weight'],
      imageUrl: json['imageUrl'],
      pickupDropoffTime: json['pickupDropoffTime'],
      addressesForPickup: json['addressesForPickup'],
      contactNumber: json['contactNumber'],
      qrCode: json['qrCode'],
      status: json['status'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      "id": donation.id,
      "category": donation.category,
      "isForPickup": donation.isForPickup,
      "weight": donation.weight,
      "imageUrl": donation.imageUrl,
      "pickupDropoffTime": donation.pickupDropoffTime,
      "addressesForPickup": donation.addressesForPickup,
      "contactNumber": donation.contactNumber,
      "qrCode": donation.qrCode,
      "status": donation.status,
    };
  }
}