import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/model/delivery_address.dart';
import 'package:hungry_hour/provider/secure_storage.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
// import 'package:hungry_hour/widgets/delivery_address.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DeliveryAddressController {
  void register(
      {required String firstName,
      int? id = 0,
      required String lastName,
      required String contactNumber1,
      String? contactNumber2,
      required String areasId,
      String? street,
      String? houseNo,
      required String nearbyLandmark,
      required BuildContext ctx}) async {
    print(areasId);
    // var data = DeliveryAddress(
    //   firstName: firstName,
    //   lastName: lastName,
    //   contactNumber1: contactNumber1,
    //   areasId: areasId.toString(),
    //   nearbyLandmark: nearbyLandmark,
    // ).toJson();
    print(areasId);
    SecureStorage().getToken().then((String value) async {
      // print(va)
      var data = DeliveryAddress(
        id: id,
        firstName: firstName,
        lastName: lastName,
        contactNumber1: contactNumber1,
        contactNumber2: contactNumber2,
        areasId: areasId,
        street: street,
        houseNo: houseNo,
        nearbyLandmark: nearbyLandmark,
      ).toJson();
      print(data);

      var url = Uri.parse(DELIVERYADDRESS);
      var response = await http.post(url, body: data, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${value}"
      });
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        //Navigator.pushNamed(context, 'login');
        // Provider.of<UserProvider>(ctx, listen: false)!.addDeliveryAddress(da);

        DeliveryAddressController().getAddress().then((value) {
          Provider.of<UserProvider>(ctx, listen: true)
              .setDeliveryAddress(value);
        });
        Fluttertoast.showToast(
            msg: "Delivery Address updated successfully",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            backgroundColor: Colors.green,
            fontSize: 18.0);
        // Navigator.pushNamed(ctx, "login");
      } else {
        AwesomeDialog(
          context: NavigationService.navigatorKey.currentContext!,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error',
          desc: 'Please fill all the textfields with "*"!!!',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
      ;
    });
  }

  Future<List<DeliveryAddress>> getAddress() async {
    List<DeliveryAddress> _address = [];

    // print(data);
    SecureStorage().getToken().then((String value) async {
      var url = Uri.parse(GETDELIVERYADDRESS);
      var response = await http.post(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${value}"
      });
      print(response.body);

      if (response.statusCode == 200) {
        List res = jsonDecode(response.body);
        res.forEach((element) {
          _address.add(DeliveryAddress.fromJson(element));
        });
      }
    });
    return _address;
  }

  void deleteAddress({required int id}) async {
    //List<DeliveryAddress> _address = [];

    // print(data);
    SecureStorage().getToken().then((value) async {
      var url = Uri.parse(DELETEADDRESS);
      var response = await http.post(url, body: {
        "id": id.toString()
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${value}"
      });
      print(response.body);

      // if (response.statusCode == 200) {
      //   List res = jsonDecode(response.body);
      //
      //   res.forEach((element) {
      //     //_address.add(DeliveryAddress.fromJson(element));
      //   });
      // }
    });
    // return _address;
  }
}
