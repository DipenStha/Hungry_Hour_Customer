class Profile {
  int? id;
  String? name;
  String? email;
  String? password;
  String? photo;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.photo,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.token});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    photo = json['photo'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['photo'] = this.photo;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
