import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/ip.dart';
//import 'package:hungry_hour/home.dart';
import 'package:hungry_hour/model/profile.dart';
import 'package:hungry_hour/provider/secure_storage.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginController {
  login(
      {required String email,
      required String password,
      required BuildContext ctxt}) async {
    var url = Uri.parse(USERLOGIN);
    print(USERLOGIN);
    var response = await http.post(url,
        body: {'email': email, 'password': password},
        headers: {"Accept": "application/json"});
    print(response.body);

    if (response.statusCode == 200) {
      Profile _profile = Profile.fromJson(jsonDecode(response.body));
      Provider.of<UserProvider>(ctxt, listen: false).setUser(profile: _profile);
      print(_profile.token);
      SecureStorage().setToken(_profile.token!).then((value) {});
      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0);
      Navigator.pushNamedAndRemoveUntil(ctxt, 'main_page', (route) => false);
      // ignore: avoid_print
      print("success");
    } else {
      AwesomeDialog(
        context: ctxt,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Login Error',
        desc: 'Invalid email or password',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
      print(response.body);
    }
  }
}
