class SlidersModel {
  SlidersModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<Data_item> data;
  final String? message;

  factory SlidersModel.fromJson(Map<String, dynamic> json) {
    return SlidersModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<Data_item>.from(json["data"]!.map((x) => Data_item.fromJson(x))),
      message: json["message"],
    );
  }
}

class Data_item {
  Data_item({
    required this.id,
    required this.imgPath,
  });

  final int? id;
  final String? imgPath;

  factory Data_item.fromJson(Map<String, dynamic> json) {
    return Data_item(
      id: json["id"],
      imgPath: json["img_path"],
    );
  }
}
