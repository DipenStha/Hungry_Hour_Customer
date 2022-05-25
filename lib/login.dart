import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/login_controller.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String errormsg;
  late bool error, showprogress;
  late String username, password;
  bool _isVisible = false;

  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _showPassword = false;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    username = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  startLogin() async {
    String apiurl = "http://localhost/HungryHour/public/api/login"; //api url
    print(username);

    var response = await http.post(Uri.parse(apiurl), body: {
      'username': _username, //get the username text
      'password': _password //get password text
    });

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["error"]) {
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      } else {
        if (jsondata["success"]) {
          setState(() {
            error = false;
            showprogress = true;
          });
          //save the data returned from server
          //and navigate to home page
          //int Id = jsondata["id"];
          String name = jsondata["name"];
          //String email = jsondata["email"];
          //String password = jsondata["password"];
          // ignore: avoid_print
          print(name);
          //user shared preference to save data
        } else {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    } else {
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              // width: 520,
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 60),
                  CircleAvatar(
                    radius: 150,
                    backgroundImage: AssetImage("assets/loginn.jpg"),
                  ),
                  // Image.asset(
                  //   "assets/login.jpg",
                  //   height: 450,
                  //   width: 530,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
                    onChanged: (value) {
                      //set username  text on change
                      username = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _password,
                    obscureText: _isVisible ? false : true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.green),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          updateStatus();
                        },
                        child: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          semanticLabel:
                              _isVisible ? 'show password' : 'hide password',
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.5)),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff4c505b),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'forgot_password');
                        },
                        child: const Text(
                          'Click Here',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 13,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MaterialButton(
                      height: 50,
                      color: Colors.teal,
                      minWidth: 350,
                      textColor: Colors.white,
                      child: const Text("LOGIN"),
                      onPressed: () {
                        if (_username.text == "" || _password.text == "") {
                          Fluttertoast.showToast(
                            msg: "Email or Password field left blank!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            fontSize: 16.0,
                            textColor: Colors.white,
                            backgroundColor: Colors.redAccent,
                          );
                        } else {
                          LoginController().login(
                              email: _username.text,
                              password: _password.text,
                              ctxt: context);
                        }
                        splashColor:
                        Colors.redAccent;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        "Don't have Account?",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xff4c505b),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              color: Color(0xff4c505b),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('errormsg', errormsg));
  }
}
