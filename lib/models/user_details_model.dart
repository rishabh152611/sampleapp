
import 'address_model.dart';


class UserDetails {
  double? dCreationTime;
  String? sId;
  List<Addresses>? addresses;
  String? email;
  String? name;
  String? phone;
  String? userId;
  String? userStatus;

  UserDetails(
      {this.dCreationTime,
      this.sId,
      this.addresses,
      this.email,
      this.name,
      this.phone,
      this.userId,
      this.userStatus});

  UserDetails.fromJson(Map<String, dynamic> json) {
    dCreationTime = json['_creationTime'];
    sId = json['_id'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses.fromJson(v));
      });
    }
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    userId = json['userId'];
    userStatus = json['userStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_creationTime'] = this.dCreationTime;
    data['_id'] = this.sId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    data['userStatus'] = this.userStatus;
    return data;
  }
}



// class UserDetails {
//   double? dCreationTime;
//   String? sId;
//   List<Addresses>? addresses;
//   String? email;
//   String? name;
//   String? phone;
//   String? userId;

//   UserDetails(
//       {this.dCreationTime,
//       this.sId,
//       this.addresses,
//       this.email,
//       this.name,
//       this.phone,
//       this.userId});

//   UserDetails.fromJson(Map<String, dynamic> json) {
//     dCreationTime = json['_creationTime'];
//     sId = json['_id'];
//     if (json['addresses'] != null) {
//       addresses = <Addresses>[];
//       json['addresses'].forEach((v) {
//         addresses!.add(new Addresses.fromJson(v));
//       });
//     }
//     email = json['email'];
//     name = json['name'];
//     phone = json['phone'];
//     userId = json['userId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_creationTime'] = this.dCreationTime;
//     data['_id'] = this.sId;
//     if (this.addresses != null) {
//       data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
//     }
//     data['email'] = this.email;
//     data['name'] = this.name;
//     data['phone'] = this.phone;
//     data['userId'] = this.userId;
//     return data;
//   }
// }



class UserAddress {
  String? label;
  String? street;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? latitude;
  String? longitude;

  UserAddress(
      {this.label,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.country,
      this.latitude,
      this.longitude});

  UserAddress.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
