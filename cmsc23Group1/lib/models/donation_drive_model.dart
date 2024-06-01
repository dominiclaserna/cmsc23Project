import '../models/donation_model.dart';

class DonationDrive {
  final String owner;
  final String driveName;
  final bool isOpen;

  DonationDrive({
    required this.owner,
    required this.driveName,
    required this.isOpen,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      owner: json['owner'],
      driveName: json['driveName'],
      isOpen: json['isOpen'] ?? true, // Default value is false if not provided
    );
  }
}
