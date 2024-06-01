import 'package:flutter/material.dart';
import 'package:week9/donation/firebase_donation_api.dart';
import 'donation_model.dart';

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
  String? get receiver => _donationFormData.receiver;
  String? get sender => _donationFormData.sender;
  String? get driveName =>
      _donationFormData.driveName;

  void updateCategory(String category, bool isSelected) {
    if (isSelected) {
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

  void updateReceiver(String receiverEmail) {
    _donationFormData.receiver = receiverEmail;
    print("Receiver: ${_donationFormData.receiver}");
    notifyListeners();
  }

  void updateSender(String sender) {
    _donationFormData.sender = sender;
    print("Sender: ${_donationFormData.sender}");
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

  void updateDriveName(String? driveName) {
    // Method to update driveName
    _donationFormData.driveName = driveName;
    notifyListeners();
  }

  void resetForm() {
    print("Resetting the form data for donations.");
    _donationFormData = Donation.emptyDonation();
    notifyListeners();
  }

  Future<void> submitForm() async {
    // Call your API or service to submit the form
  }
}
