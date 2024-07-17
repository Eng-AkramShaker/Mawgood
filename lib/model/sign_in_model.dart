class SignIn {
  SignIn({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory SignIn.fromJson(Map<String, dynamic> json) {
    return SignIn(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
    );
  }
}

class Data {
  Data({
    required this.token,
    required this.name,
  });

  final String? token;
  final String? name;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json["token"],
      name: json["name"],
    );
  }
}
