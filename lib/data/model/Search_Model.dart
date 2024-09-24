class SearchModel {
  SearchModel({
    required this.success,
    required this.data,
    required this.message,
  });

  var success;
  final List<Datum> data;
  final String? message;

  factory SearchModel.fromJson(Map<dynamic, dynamic> json) {
    return SearchModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      message: json["message"] as String?,
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.views,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng,
    required this.category,
    required this.category_id,
    required this.favorite,
    required this.media,
    required this.reviews,
    required this.rating,
    required this.avgRating,
  });

  final dynamic id; // Consider changing to int or String based on your data
  final List<dynamic> views;
  final String? name;
  final String? address;
  final String? description;
  final double? lat;
  final double? lng;
  final String? category;
  final String? category_id;
  var favorite;
  final List<dynamic> media;
  final List<Review> reviews;
  final double? rating;
  final double? avgRating;

  Datum copyWith({
    dynamic id,
    List<dynamic>? views,
    String? name,
    String? address,
    String? description,
    double? lat,
    double? lng,
    String? category,
    String? category_id,
    var favorite,
    List<dynamic>? media,
    List<Review>? reviews,
    double? rating,
    double? avgRating,
  }) {
    return Datum(
      id: id ?? this.id,
      views: views ?? this.views,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      category: category ?? this.category,
      category_id: category_id ?? this.category_id,
      favorite: favorite ?? this.favorite,
      media: media ?? this.media,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      avgRating: avgRating ?? this.avgRating,
    );
  }

  factory Datum.fromJson(Map<dynamic, dynamic> json) {
    return Datum(
      id: json["id"], // Assuming id can be dynamic
      views: json["views"] is List ? List<dynamic>.from(json["views"]) : [],
      name: _parseToString(json["name"]),
      address: _parseToString(json["address"]),
      description: _parseToString(json["description"]),
      lat: _parseToDouble(json["lat"]),
      lng: _parseToDouble(json["lng"]),
      category: _parseToString(json["category"]),
      category_id: _parseToString(json["category_id"]),
      favorite: json["favorite"],
      media: json["media"] is List ? List<dynamic>.from(json["media"]) : [],
      reviews: json["reviews"] is List ? List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))) : [],
      rating: _parseToDouble(json["rating"]),
      avgRating: _parseToDouble(json["avg_rating"]),
    );
  }

  // Helper method to handle parsing to String
  static String? _parseToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString(); // Convert int and other types to String
  }

  // Helper method to handle parsing to double
  static double? _parseToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed;
    }
    return null;
  }
}

class Review {
  Review({
    required this.id,
    required this.user,
    required this.comment,
    required this.rating,
  });

  var id;
  final User? user;
  final String? comment;
  final String? rating;

  factory Review.fromJson(Map<dynamic, dynamic> json) {
    return Review(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      comment: json["comment"],
      rating: json["rating"],
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
  });

  var id;
  final String? name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
    );
  }
}
