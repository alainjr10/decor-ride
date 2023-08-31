class SigninUserEntity {
  final String email;
  final String password;

  SigninUserEntity({
    required this.email,
    required this.password,
  });

  // to json
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
