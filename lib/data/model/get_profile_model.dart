class GetProfileModel {
  GetProfileModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool success;
  final Data? data;
  final String? message;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      success: json["success"] ?? false,
      data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      message: json["message"] ?? '',
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.profile,
    required this.favorites,
    required this.subscriptions,
  });

  final int id;
  final String name;
  final Profile? profile;
  final List<Favorite> favorites;
  final List<dynamic> subscriptions;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      profile: json["profile"] != null ? Profile.fromJson(json["profile"]) : null,
      favorites: json["favorites"] != null ? List<Favorite>.from(json["favorites"].map((x) => Favorite.fromJson(x))) : [],
      subscriptions: json["subscriptions"] != null ? List<dynamic>.from(json["subscriptions"]) : [],
    );
  }
}

class Favorite {
  Favorite({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.createdAt,
    required this.updatedAt,
    required this.place,
  });

  final int? id;
  final int? userId;
  final int? placeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Place? place;

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json["id"],
      userId: json["user_id"],
      placeId: json["place_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      place: json["place"] == null ? null : Place.fromJson(json["place"]),
    );
  }
}

class Place {
  Place({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.name,
    required this.address,
    required this.description,
    required this.isFeatured,
    required this.status,
    required this.lat,
    required this.lng,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
  });

  final int? id;
  final int? userId;
  final int? categoryId;
  final String? name;
  final String? address;
  final String? description;
  final int? isFeatured;
  final int? status;
  final String? lat;
  final String? lng;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Media> media;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["id"],
      userId: json["user_id"],
      categoryId: json["category_id"],
      name: json["name"],
      address: json["address"],
      description: json["description"],
      isFeatured: json["is_featured"],
      status: json["status"],
      lat: json["lat"],
      lng: json["lng"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    );
  }
}

class Media {
  Media({
    required this.id,
    required this.placeId,
    required this.image,
    required this.type,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
    required this.img_path,
  });

  final int? id;
  final int? placeId;
  final String? image;
  final String? type;
  final int? cover;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? img_path;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      placeId: json["place_id"],
      image: json["image"],
      type: json["type"],
      cover: json["cover"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      img_path: json["img_path"],
    );
  }
}

class Profile {
  Profile({
    required this.id,
    required this.gender,
    required this.dateOfBirth,
  });

  final int? id;
  final String? gender;
  final String? dateOfBirth;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      gender: json["gender"],
      dateOfBirth: json["date_of_birth"],
    );
  }
}
