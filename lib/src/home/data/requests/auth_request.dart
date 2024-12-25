
class AuthRequest {

  String email;
  String password;

  AuthRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };

  factory AuthRequest.fromJson(Map<String, dynamic> json) => AuthRequest(
    email: json['email'], 
    password: json['password'],
  );
}