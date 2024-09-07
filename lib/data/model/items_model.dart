class ItemsModel {
  ItemsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<Product_model> data;
  final String? message;

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<Product_model>.from(json["data"]!.map((x) => Product_model.fromJson(x))),
      message: json["message"],
    );
  }
}

class Product_model {
  Product_model({
    required this.id,
    required this.name,
    required this.appearHome,
    required this.imgPath,
  });

  final int? id;
  final String? name;
  final int? appearHome;
  final String? imgPath;

  factory Product_model.fromJson(Map<String, dynamic> json) {
    return Product_model(
      id: json["id"],
      name: json["name"],
      appearHome: json["appear_home"],
      imgPath: json["img_path"],
    );
  }
}
