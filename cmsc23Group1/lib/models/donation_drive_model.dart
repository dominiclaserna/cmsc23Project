import '../donation/donation_model.dart';

class DonationDrive {
  final String name;
  final DateTime date;
  final String location;
  final String description;
  final List<Donation> donations;

  DonationDrive({
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    this.donations = const [],
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      description: json['description'],
      donations: (json['donations'] as List<dynamic>)
          .map((donationJson) => Donation.fromJson(donationJson))
          .toList(),
    );
  }
}