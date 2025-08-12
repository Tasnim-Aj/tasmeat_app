class LoginRequest {
  String username;
  String password;

//<editor-fold desc="Data Methods">
  LoginRequest({
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginRequest &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password);

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'LoginRequest{' +
        ' username: $username,' +
        ' password: $password,' +
        '}';
  }

  LoginRequest copyWith({
    String? username,
    String? password,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
