class GetRestaurant {
  int? id;
  String? name;
  String? logo;
  String? address;
  String? status;
  String? openFrom;
  String? closeAt;
  String? createdAt;
  String? updatedAt;
  List<Categories>? categories;

  GetRestaurant(
      {this.id,
      this.name,
      this.logo,
      this.address,
      this.status,
      this.openFrom,
      this.closeAt,
      this.createdAt,
      this.updatedAt,
      this.categories});

  GetRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    status = json['status'];
    openFrom = json['open_from'];
    closeAt = json['close_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(new Categories.fromJson(v));
      });
    }
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
    if (this.categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<GetFoods> getFoods = [];

  Categories(
      {this.id, this.name, this.createdAt, this.updatedAt, required this.getFoods});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_foods'] != null) {
      getFoods = [];
      json['get_foods'].forEach((v) {
        getFoods!.add(new GetFoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getFoods != null) {
      data['get_foods'] = this.getFoods?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetFoods {
  int? id;
  int? restaurantId;
  String? name;
  int? count = 0;
  bool? isFav = false;
  String? price;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  GetFoods(
      {this.id,
      this.restaurantId,
      this.name,
      this.price,
      this.isFav,
      this.count,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  GetFoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    price = json['price'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
