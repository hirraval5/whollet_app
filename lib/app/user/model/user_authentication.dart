class UserAuthentication {
  final String accessToken;

  const UserAuthentication({required this.accessToken});

  factory UserAuthentication.fromJson(Map<String, dynamic> json) => UserAuthentication(accessToken: json['access_token']);

  Map<String, dynamic> toJson() => {"access_token": accessToken};

  @override
  String toString() => 'UserAuthentication{accessToken: $accessToken}';
}
