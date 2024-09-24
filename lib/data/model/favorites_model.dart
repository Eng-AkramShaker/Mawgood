class FavoritesModel {
  FavoritesModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<dynamic> data;
  final String? message;

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
      message: json["message"],
    );
  }
}
