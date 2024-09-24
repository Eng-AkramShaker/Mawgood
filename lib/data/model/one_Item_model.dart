class OneItemModel {
  OneItemModel({
    required this.success,
    required this.data,
    required this.message,
  });

  final bool? success;
  final Details? data;
  final String? message;

  factory OneItemModel.fromJson(Map<String, dynamic> json) {
    return OneItemModel(
      success: json["success"],
      data: json["data"] == null ? null : Details.fromJson(json["data"]),
      message: json["message"],
    );
  }
}

class Details {
  Details({
    required this.id,
    required this.views,
    required this.name,
    required this.address,
    required this.description,
    required this.lat,
    required this.lng,
    required this.category,
    required this.categoryId,
    required this.favorite,
    required this.links,
    required this.contacts,
    required this.media,
    required this.reviews,
    required this.rating,
    required this.avgRating,
  });

  var id;
  var views;
  final String? name;
  final List<Address> address;
  final String? description;
  final String? lat;
  final String? lng;
  final String? category;
  var categoryId;
  var favorite;
  final List<Links> links;
  final List<Contact> contacts;
  final List<Media> media;
  final List<Review> reviews;
  final String? rating;
  var avgRating;

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      id: json["id"],
      views: json["views"],
      name: json["name"],
      address: json["address"] == null ? [] : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      description: json["description"],
      lat: json["lat"],
      lng: json["lng"],
      category: json["category"],
      categoryId: json["category_id"],
      favorite: json["favorite"],
      links: json["links "] == null ? [] : List<Links>.from(json["links "].map((x) => Links.fromJson(x))),
      contacts: json["contacts"] == null ? [] : List<Contact>.from(json["contacts"].map((x) => Contact.fromJson(x))),
      media: json["media"] == null ? [] : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      rating: json["rating"],
      avgRating: json["avg_rating"],
    );
  }
}

class Address {
  Address({required this.id, required this.address});

  var id;
  final String? address;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      address: json["address"],
    );
  }
}

class Contact {
  Contact({required this.id, required this.phone});

  var id;
  final String? phone;

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json["id"],
      phone: json["phone"],
    );
  }
}

class Links {
  Links({required this.id, required this.link});

  var id;
  final String? link;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      id: json["id"],
      link: json["link"],
    );
  }
}

class Media {
  Media({required this.id, required this.imgPath, required this.type, required this.cover});

  var id;
  final String? imgPath;
  final String? type;
  var cover;

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["id"],
      imgPath: json["img_path"],
      type: json["type"],
      cover: json["cover"],
    );
  }
}

class Review {
  Review({required this.id, required this.user, required this.comment, required this.rating});

  var id;
  final User? user;
  final String? comment;
  final String? rating;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      comment: json["comment"],
      rating: json["rating"],
    );
  }
}

class User {
  User({required this.id, required this.name});

  var id;
  final String? name;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
    );
  }
}
