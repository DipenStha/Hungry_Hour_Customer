class Restaurant {
  int? id;
  String? name;
  String? logo;
  String? address;
  String? status;
  String? openFrom;
  String? closeAt;
  String? createdAt;
  String? updatedAt;

  Restaurant(
      {this.id,
      this.name,
      this.logo,
      this.address,
      this.status,
      this.openFrom,
      this.closeAt,
      this.createdAt,
      this.updatedAt});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    status = json['status'];
    openFrom = json['open_from'];
    closeAt = json['close_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['status'] = this.status;
    data['open_from'] = this.openFrom;
    data['close_at'] = this.closeAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
