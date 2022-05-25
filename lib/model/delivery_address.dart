class DeliveryAddress {
  String? firstName;
  String? lastName;
  int? userId;
  String? contactNumber1;
  String? contactNumber2;
  String? areasId;
  String? street;
  String? houseNo;
  String? nearbyLandmark;
  String? updatedAt;
  String? createdAt;
  int? id;

  DeliveryAddress(
      {required this.firstName,
      required this.lastName,
      this.userId,
      required this.contactNumber1,
      required this.contactNumber2,
      required this.areasId,
      required this.street,
      required this.houseNo,
      required this.nearbyLandmark,
      this.updatedAt,
      this.createdAt,
      this.id});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    userId = json['user_id'];
    contactNumber1 = json['contact_number1'];
    contactNumber2 = json['contact_number_2'];
    areasId = json['areas_id'].toString();
    street = json['street'];
    houseNo = json['house_no'];
    nearbyLandmark = json['nearby_landmark'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName ?? "";
    data['last_name'] = this.lastName ?? "";
    data['user_id'] = this.userId ?? "";
    data['contact_number1'] = this.contactNumber1 ?? "";
    data['contact_number_2'] = this.contactNumber2 ?? "";
    data['areas_id'] = this.areasId ?? "";
    data['street'] = this.street ?? "";
    data['house_no'] = this.houseNo ?? "";
    data['nearby_landmark'] = this.nearbyLandmark ?? "";
    data['updated_at'] = this.updatedAt ?? "";
    data['created_at'] = this.createdAt ?? "";
    data['id'] = this.id.toString();
    return data;
  }
}
