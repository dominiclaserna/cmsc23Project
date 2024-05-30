// lib/providers/form_provider.dart
// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:week9/donation/firebase_donation_api.dart';
import './donation_model.dart';

  // String? id;
  // List<String>? category;
  // bool? isForPickup;
  // Double? weight;
  // String? imageUrl;
  // DateTime? pickupDropoffTime;
  // List<String>? addressesForPickup;
  // String? contactNumber;
  // String? qrCode;
  // String? status;

class DonationFormProvider with ChangeNotifier {
  Donation _donationFormData = Donation.emptyDonation();
  
  final List<String> _selectedCategories = [];

  String categoryErrorMessage = "";
  String pickupErrorMessage = "";
  String weightErrorMessage = "";
  String pickDropTimeErrorMessage = "";
  String addressErrorMessage = "";
  String contactNumErrorMessage = "";



  Donation get donationFormData => _donationFormData;
  List<String> get selectedCategories => _selectedCategories;
  bool? get isForPickup => _donationFormData.isForPickup;
  double? get weight => _donationFormData.weight;
  DateTime? get pickUpDropoffTime => _donationFormData.pickupDropoffTime;
  List<String>? get addressesForPickup => _donationFormData.addressesForPickup;


  void updateCategory(String category, bool isSelected) {
    if(isSelected) {
      _selectedCategories.add(category);
    } else {
      _selectedCategories.remove(category);
    }

    _donationFormData.category = _selectedCategories;
    print(_donationFormData.category);
    notifyListeners();
  }

  void updateIsForPickup(bool isForPickup) {

    _donationFormData.isForPickup = isForPickup;
    print("Pickup: ${_donationFormData.isForPickup}");
    notifyListeners();
  }

  void updateWeight(double weight) {
    _donationFormData.weight = weight;

    print("Weight: ${_donationFormData.weight}");
    notifyListeners();
  }

  void updateAddress(List<String> addresses) {
    _donationFormData.addressesForPickup = addresses;

    print("Addresses: ${_donationFormData.addressesForPickup}");
    notifyListeners();
  }

  void updateContactNumber(String contactNumber) {
    print(contactNumber);

    _donationFormData.contactNumber = contactNumber;
    notifyListeners();
  }

  void updatePickupDropOffTime(DateTime pickupDropoffTime) {
    _donationFormData.pickupDropoffTime = pickupDropoffTime;

    print("time: ${_donationFormData.pickupDropoffTime.toString()}");
    notifyListeners();
  }

  void updateStatus(String status) {
    print(status);

    _donationFormData.status = status;
    notifyListeners();
  }

  // Add other update methods as needed

  void resetForm() {
    print("Resetting the form data for donations.");
    _donationFormData = Donation.emptyDonation();
    notifyListeners();
  }

  Future<void> submitForm() async {
    // Call your API or service to submit the form
  }
}
