class GetPlacesModel {
  GetPlacesModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final List<Places_Data> data;
  final String? message;

  factory GetPlacesModel.fromJson(Map<dynamic, dynamic> json) {
    return GetPlacesModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<Places_Data>.from(json["data"].map((x) => Places_Data.fromJson(x))),
      message: json["message"],
    );
  }
}

class Places_Data {
  Places_Data({
    required this.id,
    required this.views,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng,
    required this.category,
    required this.favorite,
    required this.links,
    required this.contacts,
    required this.media,
    required this.reviews,
    required this.rating,
  });

  final int? id;
  final int? views;
  final String? name;
  final String? address;
  final String? description;
  final String? lat;
  final String? lng;
  final String? category;
  late int favorite;
  final List<Links> links;
  final List<Contact> contacts;
  final List<Media> media;
  final List<dynamic> reviews;
  final String? rating;

  factory Places_Data.fromJson(Map<String, dynamic> json) {
    return Places_Data(
      id: json["id"],
      views: json["views"],
      name: json["name"],
      address: json["address"],
      description: json["description"],
      lat: json["lat"],
      lng: json["lng"],
      category: json["category"],
      favorite: json["favorite"],
      links: json["links "] == null ? [] : List<Links>.from(json["links "].map((x) => Links.fromJson(x))),
      contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
      media: json["media"] == null ? [] : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"].map((x) => x)),
      rating: json["rating"],
    );
  }
}

class Contact {
  Contact({
    required this.id,
    required this.phone,
  });

  final int? id;
  final String? phone;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json["id"],
      phone: json["phone"],
    );
  }
}

class Links {
  Links({
    required this.id,
    required this.link,
  });

  final int? id;
  final String? link;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      id: json["id"],
      link: json["link"],
    );
  }
}

class Media {
  Media({
    required this.id,
    required this.imgPath,
    required this.type,
    required this.cover,
  });

  final int? id;
  final String? imgPath;
  final String? type;
  final int? cover;

  factory Media.fromJson(Map<dynamic, dynamic> json) {
    return Media(
      id: json["id"],
      imgPath: json["img_path"],
      type: json["type"],
      cover: json["cover"],
    );
  }
}
