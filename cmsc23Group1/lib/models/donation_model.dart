import 'package:flutter/material.dart';

enum DonationCategory {
  Food,
  Clothes,
  Cash,
  Necessities,
  Others,
}

enum PickupType {
  Pickup,
  DropOff,
}

enum DonationStatus {
  Cancelled,
  Pending,
  Confirmed,
  ScheduledForPickup,
  Completed,
}

class Donation {
  final List<DonationCategory> categories;
  final PickupType pickupType;
  final double weight; // in kg or lbs
  final String? photoUrl; // URL to the photo of the items (optional)
  final DateTime dateTime;
  final String? address;
  final String? contactNumber;
  final String? qrCode; // QR code for drop-off (optional)
  final String? receiver; // Receiver of the donation
  final String? sender; // Sender of the donation
  final DonationStatus status; // Status of the donation
  bool isCancelled;

  Donation({
    required this.categories,
    required this.pickupType,
    required this.weight,
    this.photoUrl,
    required this.dateTime,
    this.address,
    this.contactNumber,
    this.qrCode,
    this.receiver,
    this.sender,
    this.status = DonationStatus.Pending, // Default status is Pending
    this.isCancelled = false,
  });
}
