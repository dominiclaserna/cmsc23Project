class DonationFormData {
  final List<String> categories;
  final bool isPickup;
  final double weight;
  final String pickupDropOffTime;
  final List<String> addresses; // Added addresses field
  final String? contactNumber;
  final String? senderEmail;

  DonationFormData({
    required this.categories,
    required this.isPickup,
    required this.weight,
    required this.pickupDropOffTime,
    required this.addresses, // Added addresses parameter
    this.contactNumber,
    this.senderEmail,
  });
}
