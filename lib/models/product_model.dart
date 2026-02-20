// class Product {
//   double? dCreationTime;
//   String? sId;
//   String? category;
//   String? color;
//   String? description;
//   String? details;
//   String? fabric;
//   String? fit;
//   List<Images>? images;
//   String? materialCare;
//   String? name;
//   int? price;
//   String? size;
//   String? subCategory;
//   String? sustainable;
//   List<String>? tags;

//   Product(
//       {this.dCreationTime,
//       this.sId,
//       this.category,
//       this.color,
//       this.description,
//       this.details,
//       this.fabric,
//       this.fit,
//       this.images,
//       this.materialCare,
//       this.name,
//       this.price,
//       this.size,
//       this.subCategory,
//       this.sustainable,
//       this.tags});

//   Product.fromJson(Map<String, dynamic> json) {
//     dCreationTime = json['_creationTime'];
//     sId = json['_id'];
//     category = json['category'];
//     color = json['color'];
//     description = json['description'];
//     details = json['details'];
//     fabric = json['fabric'];
//     fit = json['fit'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     materialCare = json['materialCare'];
//     name = json['name'];
//     price = json['price'];
//     size = json['size'];
//     subCategory = json['subCategory'];
//     sustainable = json['sustainable'];
//     tags = json['tags'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_creationTime'] = this.dCreationTime;
//     data['_id'] = this.sId;
//     data['category'] = this.category;
//     data['color'] = this.color;
//     data['description'] = this.description;
//     data['details'] = this.details;
//     data['fabric'] = this.fabric;
//     data['fit'] = this.fit;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['materialCare'] = this.materialCare;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['size'] = this.size;
//     data['subCategory'] = this.subCategory;
//     data['sustainable'] = this.sustainable;
//     data['tags'] = this.tags;
//     return data;
//   }
// }

// class Images {
//   String? publicId;
//   String? url;

//   Images({this.publicId, this.url});

//   Images.fromJson(Map<String, dynamic> json) {
//     publicId = json['public_id'];
//     url = json['url'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['public_id'] = this.publicId;
//     data['url'] = this.url;
//     return data;
//   }
// }


class Product {
  List<String>? availability;
  String? category;
  String? color;
  String? description;
  String? details;
  String? fabric;
  String? fit;
  List<Images>? images;
  String? materialCare;
  String? name;
  List<int>? price;
  String? productId;
  List<String>? size;
  String? status;
  Store store; // 🔹 not nullable now
  String? subCategory;
  String? sustainable;
  List<String>? tags;

  Product({
    this.availability,
    this.category,
    this.color,
    this.description,
    this.details,
    this.fabric,
    this.fit,
    this.images,
    this.materialCare,
    this.name,
    this.price,
    this.productId,
    this.size,
    this.status,
    required this.store, // 🔹 required in constructor
    this.subCategory,
    this.sustainable,
    this.tags,
  });

  Product.fromJson(Map<String, dynamic> json)
      : store = Store.fromJson(json['store'] ?? {}) { // 🔹 force store to exist
    availability = (json['availability'] as List?)?.cast<String>();
    category = json['category'];
    color = json['color'];
    description = json['description'];
    details = json['details'];
    fabric = json['fabric'];
    fit = json['fit'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    materialCare = json['materialCare'];
    name = json['name'];
    price = (json['price'] as List?)?.cast<int>();
    productId = json['productId'];
    size = (json['size'] as List?)?.cast<String>();
    status = json['status'];
    subCategory = json['subCategory'];
    sustainable = json['sustainable'];
    tags = (json['tags'] as List?)?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['availability'] = availability;
    data['category'] = category;
    data['color'] = color;
    data['description'] = description;
    data['details'] = details;
    data['fabric'] = fabric;
    data['fit'] = fit;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['materialCare'] = materialCare;
    data['name'] = name;
    data['price'] = price;
    data['productId'] = productId;
    data['size'] = size;
    data['status'] = status;
    data['store'] = store.toJson(); // 🔹 always present
    data['subCategory'] = subCategory;
    data['sustainable'] = sustainable;
    data['tags'] = tags;
    return data;
  }
}

class Images {
  String? publicId;
  String? url;

  Images({this.publicId, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_id'] = this.publicId;
    data['url'] = this.url;
    return data;
  }
}

class Store {
  Address? address;
  String? category;
  Contact? contact;
  String? storeId;
  String? storeName;
  String? storeStatus;

  Store(
      {this.address,
      this.category,
      this.contact,
      this.storeId,
      this.storeName,
      this.storeStatus});

  Store.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    category = json['category'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    storeId = json['storeId'];
    storeName = json['storeName'];
    storeStatus = json['storeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['category'] = this.category;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    data['storeId'] = this.storeId;
    data['storeName'] = this.storeName;
    data['storeStatus'] = this.storeStatus;
    return data;
  }
}

class Address {
  String? city;
  String? country;
  String? state;
  String? street;
  String? zip;

  Address({this.city, this.country, this.state, this.street, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    country = json['country'];
    state = json['state'];
    street = json['street'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['street'] = this.street;
    data['zip'] = this.zip;
    return data;
  }
}

class Contact {
  String? email;
  String? phone;

  Contact({this.email, this.phone});

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
