import 'package:flutter/material.dart';
import 'package:hungry_hour/model/delivery_address.dart';
import 'package:hungry_hour/model/get_area.dart';
import 'package:hungry_hour/model/get_restaurant.dart';
import 'package:hungry_hour/model/profile.dart';

class UserProvider with ChangeNotifier {
  // UserProvider({required GetFoods});
  Profile? profile;
  List<GetFoods>? getFoods = [];
  List<GetFoods>? getCartFood = [];
  DeliveryAddress? deliveryAddress;
  late String fName;
  late String lName;
  late String cNumber1;
  late String cNumber2;
  late String houseNo;
  late String street;
  late String nearbyLandmark;
  late Area area;
  List<DeliveryAddress> _address = [];
  DeliveryAddress? selectedArea;

  DeliveryAddress? _selectedAddress;
  //
  // void setDeliveryAddress(
  //     {required String fName,
  //     required String lName,
  //     required String cNumber1,
  //     required String cNumber2,
  //     required String street,
  //     required String houseNo,
  //     required String nearbyLandmark,
  //     required Area? area}) {
  //   this.fName = fName;
  //   this.lName = lName;
  //   this.cNumber1 = cNumber1;
  //   this.cNumber2 = cNumber2;
  //   this.street = street;
  //   this.houseNo = houseNo;
  //   this.nearbyLandmark = nearbyLandmark;
  //   this.area = area!;
  //   notifyListeners();
  // }

  List<DeliveryAddress> getDeliveryAddress() {
    print(this._address);
    return this._address;
  }

  void setUser({required Profile profile, getFavourites}) {
    this.profile = profile;
    notifyListeners();
  }
   void setProfile({required Profile profile}) {
    this.profile = profile;
    notifyListeners();
  }

  Profile getProfile() {
    return this.profile!;
  }

  void setFavourite({required GetFoods getFoods}) {
    // print(this.getFoods?.length);
    List<GetFoods> foods = this.getFoods ?? [];

    foods.add(getFoods);
    this.getFoods = foods;
    notifyListeners();
  }

  void removeFavourite({required GetFoods getFoods}) {
    // print(this.getFoods?.length);

    this.getFoods?.remove(
        this.getFoods?.where((element) => element.id == getFoods.id).first);
    notifyListeners();
  }

  List<GetFoods> getFavourite() {
    return this.getFoods ?? [];
  }

  void addToCart({required GetFoods getCartFood, int? count}) {
    List<GetFoods> foods = this.getCartFood ?? [];
    bool haveFood =
        foods.where((element) => element.id == getCartFood.id).length == 0
            ? false
            : true;

    print(haveFood);

    if (haveFood) {
      print(getCartFood.count);
      this
              .getCartFood
              ?.where((element) => element.id == getCartFood.id)
              .first
              .count =
          count ??
              ((this
                          .getCartFood
                          ?.where((element) => element.id == getCartFood.id)
                          .first
                          .count ??
                      0) +
                  1 -
                  1);
    } else {
      foods.add(getCartFood);
    }

    this.getCartFood = foods;
    print(this.getCartFood?.length);
    notifyListeners();
  }

  void removeFromCart({required GetFoods getCartFood}) {
    if (getCartFood.count == 0) {
      this.getCartFood?.remove(this
          .getCartFood
          ?.where((element) => element.id == getCartFood.id)
          .first);
    } else {
      this
          .getCartFood
          ?.where((element) => element.id == getCartFood.id)
          .first
          .count = (this
                  .getCartFood
                  ?.where((element) => element.id == getCartFood.id)
                  .first
                  .count ??
              0) -
          1;
    }
    notifyListeners();
  }

  List<GetFoods> getFoodFromCart() {
    return this.getCartFood ?? [];
  }

  void setDeliveryAddress(List<DeliveryAddress> deliveryAddress) {
    this._address = deliveryAddress;
    notifyListeners();
  }

  void addDeliveryAddress(DeliveryAddress deliveryAddress) {
    this._address.add(deliveryAddress);
    notifyListeners();
  }

  void removeDeliveryAddress(DeliveryAddress deliveryAddress) {
    this._address.remove(deliveryAddress);
    notifyListeners();
  }

  void setSelectedAddress(DeliveryAddress deliveryAddress) {
    this.selectedArea = deliveryAddress;
    notifyListeners();
  }

  void removeSelectedAddress() {
    this.selectedArea = null;
    notifyListeners();
  }

  DeliveryAddress? getSelectedAddress() {
    return this.selectedArea;
  }

  void clearCart() {
    this.getCartFood = [];
  }
}
