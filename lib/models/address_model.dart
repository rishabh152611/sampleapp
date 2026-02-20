
class Addresses {
  String? addressId;
  String? city;
  String? country;
  String? label;
  String? latitude;
  String? longitude;
  String? state;
  String? street;
  String? zip;

  Addresses(
      {this.addressId,
      this.city,
      this.country,
      this.label,
      this.latitude,
      this.longitude,
      this.state,
      this.street,
      this.zip});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    city = json['city'];
    country = json['country'];
    label = json['label'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    state = json['state'];
    street = json['street'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this.addressId;
    data['city'] = this.city;
    data['country'] = this.country;
    data['label'] = this.label;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['state'] = this.state;
    data['street'] = this.street;
    data['zip'] = this.zip;
    return data;
  }
}
