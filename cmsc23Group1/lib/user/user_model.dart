// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class User {
  String? id;
  String name;
  String username;
  String email;
  String contact_number;
  List<String> addresses;
  bool isOrganization;

  User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.contact_number,
    required this.addresses,
    required this.isOrganization
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      contact_number: json['contact_number'],
      addresses: json['addresses'],
      isOrganization: json['isOrganization'],
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'contact_number': user.contact_number,
      'addresses': user.addresses,
      'isOrganization': user.isOrganization,
    };
  }
}