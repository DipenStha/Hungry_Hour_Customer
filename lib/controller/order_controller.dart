import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/provider/secure_storage.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future<void> createOrder({bool isPaid = false}) async {
    UserProvider _userProvider = Provider.of<UserProvider>(
        NavigationService.navigatorKey.currentContext!,
        listen: false);
    List OrderDetails = [];
    print(_userProvider.getCartFood?.length);

    for (var e in _userProvider.getCartFood!) {
      // int? total = (e.price ?? 0 * e.count!) as int?;
      var orderDetial = {
        "food_id": e.id,
        "quantity": e.count,
        "total": (e.price ?? 0 * e.count!).toString()
      };
      OrderDetails.add(orderDetial);
    }
    int delivery_addresses_id = _userProvider.getSelectedAddress()!.id ?? 0;
    String order_date = DateTime.now().toString();
    Set<int?> res =
        _userProvider.getCartFood!.map((e) => e.restaurantId).toSet();
    int count = _userProvider.getCartFood!
        .where((element) => element.count != 0)
        .map((e) => e.restaurantId)
        .toSet()
        .toList()
        .length;
    int deliveryCharge = (count) * 100;
    int subtotal = 0;
    int serviceCharge = 0;
    int vatAmount = 0;

    _userProvider.getCartFood?.forEach((element) {
      subtotal = subtotal + ((element.count ?? 0) * int.parse(element.price!));
    });

    serviceCharge = (subtotal * (10 / 100)).round();
    vatAmount = (subtotal * (13 / 100)).round();
    int total = subtotal + deliveryCharge + serviceCharge + vatAmount;
    print(total);

    var url = Uri.parse(CREATEORDER);
    print(CREATEORDER.toString());
    SecureStorage().getToken().then((value) async {
      var response = await http.post(url, body: {
        'delivery_addresses_id': delivery_addresses_id.toString(),
        'order_date': order_date,
        "isPaid": isPaid.toString(),
        'sub_total': subtotal.toString(),
        'delivery_charge': deliveryCharge.toString(),
        'service_charge': serviceCharge.toString(),
        'vat_amount': vatAmount.toString(),
        'order_total': total.toString(),
        "order_details": jsonEncode(OrderDetails)
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${value}"
      });
      print(response.body);
      if (response.statusCode == 201) {
        //Navigator.pushNamed(context, 'login');
        Fluttertoast.showToast(
            msg: "Order Successful",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.black,
            backgroundColor: Colors.greenAccent,
            fontSize: 18.0);
        _userProvider.clearCart();
        Navigator.pushNamedAndRemoveUntil(
            NavigationService.navigatorKey.currentContext!,
            "main_page",
            (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "Order failled!!! \n Try again!!!",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 18.0);
      }
    });
  }
}
