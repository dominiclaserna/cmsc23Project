import 'dart:convert';

enum UserType { donor, organization, admin }

class User {
  String? id;
  String name;
  String username;
  String email;
  String contact_number;
  List<String> addresses;
  UserType userType;

  User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.contact_number,
    required this.addresses,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      contact_number: json['contact_number'],
      addresses: List<String>.from(json['addresses']),
      userType: UserType.values.firstWhere(
        (type) => type.toString() == 'UserType.' + json['userType'],
      ),
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'contact_number': contact_number,
      'addresses': addresses,
      'userType': userType.toString().split('.').last,
    };
  }
}
