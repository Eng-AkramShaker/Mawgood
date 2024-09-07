class PrivacyPolicyAboutUsModel {
  PrivacyPolicyAboutUsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory PrivacyPolicyAboutUsModel.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicyAboutUsModel(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.privacyPolicy,
    required this.aboutUs,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? privacyPolicy;
  final String? aboutUs;
  final dynamic createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      privacyPolicy: json["privacy_policy"],
      aboutUs: json["about_us"],
      createdAt: json["created_at"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
