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
  String? receiver;
  String? sender;
  String? driveName; // Add this field

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
    this.receiver,
    this.sender,
    this.driveName, // Add this field
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
    receiver = null;
    sender = null;
    driveName = null; // Initialize the driveName field
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
      receiver: json['receiver'],
      sender: json['sender'],
      driveName: json['driveName'], // Add this field
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    // Modify toJson method to remove donation parameter
    return {
      "id": id,
      "category": category,
      "isForPickup": isForPickup,
      "weight": weight,
      "imageUrl": imageUrl,
      "pickupDropoffTime": pickupDropoffTime,
      "addressesForPickup": addressesForPickup,
      "contactNumber": contactNumber,
      "qrCode": qrCode,
      "status": status,
      "receiver": receiver,
      "sender": sender,
      "driveName": driveName, // Add this field
    };
  }
}
