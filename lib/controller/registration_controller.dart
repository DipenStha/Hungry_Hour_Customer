import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/constants/colors.dart';
import 'package:hungry_hour/controller/ip.dart';
//import 'package:hungry_hour/login.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

class RegistrationController {
  register(
      {required String name,
      required String email,
      required String password,
      required BuildContext ctx}) async {
    /*if (name == "" || email == "" || password == "" || repeatpassword == "") {
      Fluttertoast.showToast(
          msg: "Registration Failled!\nFields cannot be left blank",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 16.0);
    } else if (password == repeatpassword) {
      var url = Uri.parse('http://10.80.96.33/HungryHour/public/api/create');
      var response = await http.post(url, body: {
        'name': name,
        'email': email,
        'password': password,
      }, headers: {
        "Accept": "application/json"
      });
      if (response.statusCode == 201) {
        //Navigator.pushNamed(context, 'login');
        Fluttertoast.showToast(
            msg: "Registration Successful",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.black,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            gravity: ToastGravity.CENTER,
            fontSize: 18.0);
        Navigator.pushNamed(ctx, "login");
      } else {
        Fluttertoast.showToast(
            msg: "Registration failled!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
        msg: "Both passwords must be same",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    }
    */
    var url = Uri.parse(USERREGISTRATION);
    var response = await http.post(url, body: {
      'name': name,
      'email': email,
      'password': password,
    }, headers: {
      "Accept": "application/json"
    });
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 201) {
      //Navigator.pushNamed(context, 'login');
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          fontSize: 18.0);
      Navigator.pushNamed(ctx, "login");
    } else {
      AwesomeDialog(
        context: ctx,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Registration Error',
        desc: 'Email already registered.\nPlease proceed to login',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
    // else if (response.statusCode == 422){
    //   AwesomeDialog(
    //     context: ctx,
    //     dialogType: DialogType.ERROR,
    //     animType: AnimType.BOTTOMSLIDE,
    //     title: 'Registration Error',
    //     desc: 'Please enter valid details',
    //     btnCancelOnPress: () {},
    //     btnOkOnPress: () {},
    //   ).show();
    // }
  }
}

Future<bool> ForgotPasswordController(
    {required String email,
    // required String otp,
    // required String new_password,
    required BuildContext ctx}) async {
  bool _isValid = false;
  var url = Uri.parse(FORGOTPASSWORD);
  var response = await http.post(url, body: {
    'email': email, //'otp': otp, 'new_password': new_password
  }, headers: {
    'Accept': 'application/json',
  });
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    _isValid = true;
    Fluttertoast.showToast(
      msg: "User Found!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pushNamed(ctx, "login");
  } else if (response.statusCode == 422) {
    print(response.body);
    Fluttertoast.showToast(
      msg: "Invalid Email!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else {
    Fluttertoast.showToast(
      msg: "Unknown Error!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  return _isValid;
}

Future<bool> CheckOtp(
    {required String email,
    required String otp,
    required BuildContext ctx}) async {
  bool _isValid = false;
  var url = Uri.parse(VERIFYOTP);
  var response = await http.post(url, body: {
    'email': email,
    'otp': otp,
  }, headers: {
    'Accept': 'application/json',
  });
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    _isValid = true;
    Fluttertoast.showToast(
      msg: "OTP Match",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    //Navigator.pushNamed(ctx, "/login");

  } else {
    print(response.body);
    Fluttertoast.showToast(
      msg: "Invalid OTP!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  return _isValid;
}

// Future<bool> ChangePassword(
//     {required String email,
//     required String otp,
//     required String new_password,
//     required BuildContext ctx}) async {
//   bool _isValid = false;
//   var url = Uri.parse(CHANGEPASSWORD);
//   var response = await http.post(url, body: {
//     'email': email,
//     'otp': otp,
//     'new_password': new_password
//   }, headers: {
//     'Accept': 'application/json',
//   });
//   print(response.body);
//   if (response.statusCode == 200) {
//     _isValid = true;
//     Fluttertoast.showToast(
//       msg: "Password Changed Successfully!",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//     Navigator.pushNamed(ctx, "/login");
//   } else {
//     print(response.body);
//     Fluttertoast.showToast(
//       msg: "Invalid Data",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
//   return _isValid;
// }

class UpdateProfileController {
  update({required String photo, required BuildContext ctx}) async {
    var url = Uri.parse(UPDATEPROFILE);
    var response = await http.post(url, body: {
      'photo': photo,
    }, headers: {
      "Accept": "application/json"
    });
    //print(response.body);
    if (response.statusCode == 201) {
      //Navigator.pushNamed(context, 'login');
      Fluttertoast.showToast(
          msg: "Photo updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white10,
          fontSize: 18.0);
      Navigator.pushNamed(ctx, "user_profile");
    } else {
      AwesomeDialog(
        context: ctx,
        dialogType: DialogType.INFO,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Update error',
        // desc: 'Email already registered.\nPlease proceed to login',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }
}
