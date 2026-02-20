// import 'product_model.dart';

// class CartModel {
//   double? dCreationTime;
//   String? sId;
//   int? addedAt;
//   int? colorIndex;
//   int? optionIndex;
//   Product? product;
//   String? productId;
//   int? quantity;
//   String? userId;

//   CartModel(
//       {this.dCreationTime,
//       this.sId,
//       this.addedAt,
//       this.colorIndex,
//       this.optionIndex,
//       this.product,
//       this.productId,
//       this.quantity,
//       this.userId});

//   CartModel.fromJson(Map<String, dynamic> json) {
//     dCreationTime = json['_creationTime'];
//     sId = json['_id'];
//     addedAt = json['addedAt'];
//     colorIndex = json['colorIndex'];
//     optionIndex = json['optionIndex'];
//     product =
//         json['product'] != null ? new Product.fromJson(json['product']) : null;
//     productId = json['productId'];
//     quantity = json['quantity'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_creationTime'] = this.dCreationTime;
//     data['_id'] = this.sId;
//     data['addedAt'] = this.addedAt;
//     data['colorIndex'] = this.colorIndex;
//     data['optionIndex'] = this.optionIndex;
//     if (this.product != null) {
//       data['product'] = this.product!.toJson();
//     }
//     data['productId'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['userId'] = this.userId;
//     return data;
//   }
// }


class CartModel {
  double? dCreationTime;
  String? sId;
  int? addedAt;
  int? colorIndex;
  int? optionIndex;
  CartProduct? product;
  String? productId;
  int? quantity;
  String? userId;

  CartModel(
      {this.dCreationTime,
      this.sId,
      this.addedAt,
      this.colorIndex,
      this.optionIndex,
      this.product,
      this.productId,
      this.quantity,
      this.userId});

  CartModel.fromJson(Map<String, dynamic> json) {
    dCreationTime = json['_creationTime'];
    sId = json['_id'];
    addedAt = json['addedAt'];
    colorIndex = json['colorIndex'];
    optionIndex = json['optionIndex'];
    product =
        json['product'] != null ? new CartProduct.fromJson(json['product']) : null;
    productId = json['productId'];
    quantity = json['quantity'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_creationTime'] = this.dCreationTime;
    data['_id'] = this.sId;
    data['addedAt'] = this.addedAt;
    data['colorIndex'] = this.colorIndex;
    data['optionIndex'] = this.optionIndex;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['userId'] = this.userId;
    return data;
  }
}

class CartProduct {
  double? dCreationTime;
  String? sId;
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
  List<int>? quantity;
  List<String>? size;
  String? status;
  String? storeId;
  String? subCategory;
  String? sustainable;
  List<String>? tags;

  CartProduct(
      {this.dCreationTime,
      this.sId,
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
      this.quantity,
      this.size,
      this.status,
      this.storeId,
      this.subCategory,
      this.sustainable,
      this.tags});

  CartProduct.fromJson(Map<String, dynamic> json) {
    dCreationTime = json['_creationTime'];
    sId = json['_id'];
    availability = json['availability'].cast<String>();
    category = json['category'];
    color = json['color'];
    description = json['description'];
    details = json['details'];
    fabric = json['fabric'];
    fit = json['fit'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    materialCare = json['materialCare'];
    name = json['name'];
    price = json['price'].cast<int>();
    quantity = json['quantity'].cast<int>();
    size = json['size'].cast<String>();
    status = json['status'];
    storeId = json['storeId'];
    subCategory = json['subCategory'];
    sustainable = json['sustainable'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_creationTime'] = this.dCreationTime;
    data['_id'] = this.sId;
    data['availability'] = this.availability;
    data['category'] = this.category;
    data['color'] = this.color;
    data['description'] = this.description;
    data['details'] = this.details;
    data['fabric'] = this.fabric;
    data['fit'] = this.fit;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['materialCare'] = this.materialCare;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    data['status'] = this.status;
    data['storeId'] = this.storeId;
    data['subCategory'] = this.subCategory;
    data['sustainable'] = this.sustainable;
    data['tags'] = this.tags;
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
