class CreateUserEntity {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String postCode;
  final String userType;
  final String? profilePictureUrl;

  CreateUserEntity({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.postCode,
    required this.userType,
    this.profilePictureUrl,
  });

  /// to json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'postCode': postCode,
      'userType': userType,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // to String
  @override
  String toString() {
    return 'CreateUserEntity(email: $email, password: $password, firstName: $firstName, lastName: $lastName, postCode: $postCode, userType: $userType, profilePictureUrl: $profilePictureUrl)';
  }
}
