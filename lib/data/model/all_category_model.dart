class AllCategories {
  AllCategories({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<Datum> data;
  final String? message;

  factory AllCategories.fromJson(Map<String, dynamic> json) {
    return AllCategories(
      success: json["success"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      message: json["message"],
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.appearHome,
    required this.imgPath,
  });

  final int? id;
  final String? name;
  final int? appearHome;
  final String? imgPath;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      name: json["name"],
      appearHome: json["appear_home"],
      imgPath: json["img_path"],
    );
  }
}
