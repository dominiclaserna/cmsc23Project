import 'dart:convert';
import 'dart:ffi';

class Donation {
  String? id;
  List<String>? category;
  bool? isForPickup;
  double? weight;
  String? imageUrl;
  DateTime? pickupDropoffTime;
  List<String>? addressesForPickup;
  String? contactNumber;
  String? qrCode;
  String? status;
  String? receiver; // Add this field
  String? sender; // Add this field

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
    this.qrCode,
    this.receiver, // Add this field
    this.sender, // Add this field
  });

  Donation.emptyDonation() {
    category = null;
    category = null;
    isForPickup = null;
    weight = null;
    imageUrl = null;
    addressesForPickup = null;
    contactNumber = null;
    pickupDropoffTime = DateTime.now();
    status = null;
    receiver = null; // Add this field
    sender = null; // Add this field
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
      receiver: json['receiver'], // Add this field
      sender: json['sender'], // Add this field
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
      "receiver": donation.receiver,
      "sender": donation.sender,
    };
  }
}
