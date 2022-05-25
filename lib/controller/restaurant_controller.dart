import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hungry_hour/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/model/get_restaurant.dart';
import 'package:hungry_hour/model/restaurant.dart';
import 'package:hungry_hour/restaurant_info.dart';
// import 'package:hungry_hour/provider/secure_storage.dart';
import 'package:http/http.dart' as http;

class RestaurantController {
  Future<List<Restaurant>> restaurants({String name = ""}) async {
    List<Restaurant> _rests = [];
    var url = Uri.parse(GETRESTAURANTS + '?name=$name');
    print(GETRESTAURANTS + '?name=$name');
    var response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      List res = jsonDecode(response.body);
      res.forEach((element) {
        _rests.add(Restaurant.fromJson(element));
      });
    } else {
      print(response.body);
    }
    return _rests;
  }

  Future<GetRestaurant?> restaurant(
      {required int id, required BuildContext ctx}) async {
    GetRestaurant? _rest;
    var url = Uri.parse(SHOWRESTAURANTS);
    var response = await http.post(url,
        body: {'id': id.toString()}, headers: {"Accept": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      _rest = GetRestaurant.fromJson(res);
      
      Navigator.push<void>(
        ctx,
        MaterialPageRoute(
          builder: (BuildContext context) => RestaurantInfo(
            getRestaurant: _rest,
          ),
        ),
      );
      // print(res);
    } else {
      print(response.body);
    }
    return _rest;
  }
}
