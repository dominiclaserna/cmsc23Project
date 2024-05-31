import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationAPI {
  static Future<void> updateOrganizationDescription(
      String? email, String newDescription, bool acceptingDonations) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'description': newDescription,
          'acceptingDonations': acceptingDonations,
        });
        print('Organization description updated successfully');
      } else {
        print('Document with email $email does not exist');
      }
    } catch (e) {
      print('Error updating organization description: $e');
    }
  }
}
