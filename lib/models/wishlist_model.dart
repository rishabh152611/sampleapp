import 'product_model.dart';

class WishlistModel {
  double? dCreationTime;
  String? sId;
  int? createdAt;
  Product? product;
  String? productId;
  String? userId;

  WishlistModel(
      {this.dCreationTime,
      this.sId,
      this.createdAt,
      this.product,
      this.productId,
      this.userId});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    dCreationTime = json['_creationTime'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productId = json['productId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_creationTime'] = this.dCreationTime;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    return data;
  }
}
