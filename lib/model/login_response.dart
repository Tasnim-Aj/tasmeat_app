class LoginResponse {
  String access_token;
  String refresh_token;
  String token_type;

//<editor-fold desc="Data Methods">
  LoginResponse({
    required this.access_token,
    required this.refresh_token,
    required this.token_type,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginResponse &&
          runtimeType == other.runtimeType &&
          access_token == other.access_token &&
          refresh_token == other.refresh_token &&
          token_type == other.token_type);

  @override
  int get hashCode =>
      access_token.hashCode ^ refresh_token.hashCode ^ token_type.hashCode;

  @override
  String toString() {
    return 'LoginResponse{' +
        ' access_token: $access_token,' +
        ' refresh_token: $refresh_token,' +
        ' token_type: $token_type,' +
        '}';
  }

  LoginResponse copyWith({
    String? access_token,
    String? refresh_token,
    String? token_type,
  }) {
    return LoginResponse(
      access_token: access_token ?? this.access_token,
      refresh_token: refresh_token ?? this.refresh_token,
      token_type: token_type ?? this.token_type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': this.access_token,
      'refresh_token': this.refresh_token,
      'token_type': this.token_type,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      access_token: map['access_token'] as String,
      refresh_token: map['refresh_token'] as String,
      token_type: map['token_type'] as String,
    );
  }

//</editor-fold>
}
