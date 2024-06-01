import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/models/donation_model.dart';

Future<void> saveDonationToFirestore(Donation donation) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference donations = firestore.collection('donations');

    await donations.add({
      'categories': donation.categories
          .map((category) => category.toString().split('.').last)
          .toList(),
      'pickupType': donation.pickupType.toString().split('.').last,
      'weight': donation.weight,
      'dateTime': donation.dateTime,
      'address': donation.address,
      'contactNumber': donation.contactNumber,
      'isCancelled': donation.isCancelled,
      'receiver': donation.receiver,
      'sender': donation.sender,
      'driveName': donation.driveName,
      'status': "Pending",
    });

    print('Donation saved to Firestore');

    // Return a Future indicating success
    return Future.value();
  } catch (e) {
    print('Error saving donation: $e');
    // Throw an exception to indicate failure
    throw e;
  }
}

Future<void> updateDonationStatusInFirestore(
    String donationId, String newStatus) async {
  try {
    await FirebaseFirestore.instance
        .collection('donations')
        .doc(donationId)
        .update({'status': newStatus});
    print('Donation status updated to $newStatus');

    // Update status in the app
    updateAppStatus('Donation status updated successfully');
  } catch (e) {
    print('Error updating donation status: $e');
  }
}

void updateAppStatus(String status) {
  // Update status in the app UI or trigger a notification
  print('App status: $status');
}
