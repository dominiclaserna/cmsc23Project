import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/models/donation_model.dart';

void saveDonationToFirestore(Donation donation) async {
  try {
    // Access the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get a reference to the donations collection
    CollectionReference donations = firestore.collection('donations');

    // Add a new document to the donations collection
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
      'status': "Pending",
    });

    // Display a success message
    print('Donation saved to Firestore');
  } catch (e) {
    // Handle errors
    print('Error saving donation: $e');
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
  } catch (e) {
    print('Error updating donation status: $e');
  }
}
