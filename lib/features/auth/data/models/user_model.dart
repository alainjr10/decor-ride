import 'dart:convert';

class UserModel {
  final String firstName;
  final String lastName;
  final String userId;
  final String email;
  final String? phoneNumber;
  final String? profilePictureUrl;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.email,
    this.phoneNumber,
    this.profilePictureUrl,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? userId,
    String? email,
    String? phoneNumber,
    String? profilePictureUrl,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userId': userId,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      userId: map['userId'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePictureUrl: map['profilePictureUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel.fromMap(json);
}
