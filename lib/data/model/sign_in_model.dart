class SignIn {
  SignIn({
    required this.success,
    required this.data,
    required this.message,
  });

  var success;
  final Data? data;
  final String? message;

  factory SignIn.fromJson(Map<dynamic, dynamic> json) {
    return SignIn(
      success: json['success'],
      data: json['data'] == null ? null : Data.fromJson(json['data'] as Map<dynamic, dynamic>),
      message: json['message'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class Data {
  Data({
    required this.token,
    required this.name,
  });

  final String? token;
  final String? name;

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      token: json['token'],
      name: json['name'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
    };
  }
}
