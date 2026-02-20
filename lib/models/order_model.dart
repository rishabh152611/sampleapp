// class OrderModel {
//   double? dCreationTime;
//   String? sId;
//   Address? address;
//   int? createdAt;
//   List<Items>? items;
//   String? orderId;
//   String? orderStatus;
//   String? paymentId;
//   String? paymentMethod;
//   String? paymentStatus;
//   int? total;
//   String? userId;

//   OrderModel(
//       {this.dCreationTime,
//       this.sId,
//       this.address,
//       this.createdAt,
//       this.items,
//       this.orderId,
//       this.orderStatus,
//       this.paymentId,
//       this.paymentMethod,
//       this.paymentStatus,
//       this.total,
//       this.userId});

//   OrderModel.fromJson(Map<String, dynamic> json) {
//     dCreationTime = json['_creationTime'];
//     sId = json['_id'];
//     address =
//         json['address'] != null ? new Address.fromJson(json['address']) : null;
//     createdAt = json['createdAt'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//     orderId = json['orderId'];
//     orderStatus = json['orderStatus'];
//     paymentId = json['paymentId'];
//     paymentMethod = json['paymentMethod'];
//     paymentStatus = json['paymentStatus'];
//     total = json['total'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_creationTime'] = this.dCreationTime;
//     data['_id'] = this.sId;
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     data['orderId'] = this.orderId;
//     data['orderStatus'] = this.orderStatus;
//     data['paymentId'] = this.paymentId;
//     data['paymentMethod'] = this.paymentMethod;
//     data['paymentStatus'] = this.paymentStatus;
//     data['total'] = this.total;
//     data['userId'] = this.userId;
//     return data;
//   }
// }

// class Address {
//   String? city;
//   String? country;
//   String? label;
//   String? latitude;
//   String? longitude;
//   String? state;
//   String? street;
//   String? zip;

//   Address(
//       {this.city,
//       this.country,
//       this.label,
//       this.latitude,
//       this.longitude,
//       this.state,
//       this.street,
//       this.zip});

//   Address.fromJson(Map<String, dynamic> json) {
//     city = json['city'];
//     country = json['country'];
//     label = json['label'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     state = json['state'];
//     street = json['street'];
//     zip = json['zip'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['city'] = this.city;
//     data['country'] = this.country;
//     data['label'] = this.label;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['state'] = this.state;
//     data['street'] = this.street;
//     data['zip'] = this.zip;
//     return data;
//   }
// }

// class Items {
//   String? category;
//   String? color;
//   String? image;
//   String? name;
//   int? price;
//   String? productId;
//   int? quantity;
//   String? size;
//   String? subCategory;

//   Items(
//       {this.category,
//       this.color,
//       this.image,
//       this.name,
//       this.price,
//       this.productId,
//       this.quantity,
//       this.size,
//       this.subCategory});

//   Items.fromJson(Map<String, dynamic> json) {
//     category = json['category'];
//     color = json['color'];
//     image = json['image'];
//     name = json['name'];
//     price = json['price'];
//     productId = json['productId'];
//     quantity = json['quantity'];
//     size = json['size'];
//     subCategory = json['subCategory'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category'] = this.category;
//     data['color'] = this.color;
//     data['image'] = this.image;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['productId'] = this.productId;
//     data['quantity'] = this.quantity;
//     data['size'] = this.size;
//     data['subCategory'] = this.subCategory;
//     return data;
//   }
// }



import 'package:sampleapp/models/user_details_model.dart';

class OrderModel {
  double? dCreationTime;
  String? sId;
  UserAddress? address;
  int? createdAt;
  int? deliveryFee;
  List<Items>? items;
  String? orderId;
  String? orderStatus;
  String? paymentMethod;
  String? paymentStatus;
  String? storeId;
  int? taxes;
  int? total;
  String? userId;

  OrderModel(
      {this.dCreationTime,
      this.sId,
      this.address,
      this.createdAt,
      this.deliveryFee,
      this.items,
      this.orderId,
      this.orderStatus,
      this.paymentMethod,
      this.paymentStatus,
      this.storeId,
      this.taxes,
      this.total,
      this.userId});

  OrderModel.fromJson(Map<String, dynamic> json) {
    dCreationTime = json['_creationTime'];
    sId = json['_id'];
    address =
        json['address'] != null ? new UserAddress.fromJson(json['address']) : null;
    createdAt = json['createdAt'];
    deliveryFee = json['deliveryFee'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderId = json['orderId'];
    orderStatus = json['orderStatus'];
    paymentMethod = json['paymentMethod'];
    paymentStatus = json['paymentStatus'];
    storeId = json['storeId'];
    taxes = json['taxes'];
    total = json['total'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_creationTime'] = this.dCreationTime;
    data['_id'] = this.sId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['deliveryFee'] = this.deliveryFee;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['orderId'] = this.orderId;
    data['orderStatus'] = this.orderStatus;
    data['paymentMethod'] = this.paymentMethod;
    data['paymentStatus'] = this.paymentStatus;
    data['storeId'] = this.storeId;
    data['taxes'] = this.taxes;
    data['total'] = this.total;
    data['userId'] = this.userId;
    return data;
  }
}


class Items {
  String? category;
  String? color;
  String? image;
  String? name;
  int? price;
  String? productId;
  int? quantity;
  String? size;
  String? subCategory;

  Items(
      {this.category,
      this.color,
      this.image,
      this.name,
      this.price,
      this.productId,
      this.quantity,
      this.size,
      this.subCategory});

  Items.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    color = json['color'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    productId = json['productId'];
    quantity = json['quantity'];
    size = json['size'];
    subCategory = json['subCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['color'] = this.color;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    data['subCategory'] = this.subCategory;
    return data;
  }
}
