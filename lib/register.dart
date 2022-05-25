import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'controller/registration_controller.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatpassword = TextEditingController();

  bool _isVisible = false;
  bool _isVisible1 = false;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void updateStatus1() {
    setState(() {
      _isVisible1 = !_isVisible1;
    });
  }

  late bool error, sending, success;
  late String msg;
  // var phpurl = "http://10.30.108.207/dashboard/fooddelivery/registration.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  // Future<void> sendData() async {
  //   if (name.text == "" ||
  //       email.text == "" ||
  //       password.text == "" ||
  //       repeatpassword.text == "") {
  //     setState(() {
  //       sending = false;
  //       error = true;
  //       success = false;
  //       Fluttertoast.showToast(
  //           msg: "Fields cannot be left blank",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           fontSize: 16.0);
  //     });
  //   }
  //   if (password.text == repeatpassword.text) {
  //     final response = await http.post(Uri.parse(phpurl), body: {
  //       "name": name.text,
  //       "email": email.text,
  //       "password": password.text,
  //       "repeatpassword": repeatpassword.text,
  //     });
  //     if (response.statusCode == 200) {
  //       // ignore: avoid_print
  //       print(response.body); //print raw response on console
  //       var data = json.decode(response.body);
  //       if (data["error"]) {
  //         setState(() {
  //           //refresh the UI when error is recieved from server
  //           sending = false;
  //           error = true;
  //           msg = data["message"];
  //           Fluttertoast.showToast(
  //               msg: "Registration failed!",
  //               toastLength: Toast.LENGTH_SHORT,
  //               gravity: ToastGravity.CENTER,
  //               timeInSecForIosWeb: 1,
  //               backgroundColor: Colors.red,
  //               textColor: Colors.white,
  //               fontSize: 16.0); //error message from server
  //         });
  //       } else {
  //         //after write success, make fields empty
  //         setState(() {
  //           sending = false;
  //           success = true;
  //           Fluttertoast.showToast(
  //               msg: "Registration successful!",
  //               toastLength: Toast.LENGTH_SHORT,
  //               gravity: ToastGravity.CENTER,
  //               timeInSecForIosWeb: 1,
  //               backgroundColor: Colors.red,
  //               textColor: Colors.white,
  //               fontSize: 16.0);
  //           name.text = "";
  //           email.text = "";
  //           password.text = "";
  //           repeatpassword.text =
  //               ""; //mark success and refresh UI with setState
  //         });
  //       }
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: "Both passwords must be same",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //  decoration: const BoxDecoration(
      //  image: DecorationImage(
      //   image: AssetImage('assets/register.jpg'), fit: BoxFit.cover)),
      children: [
        Scaffold(
          backgroundColor: Colors.orangeAccent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  // width: 520,
                  padding: const EdgeInsets.only(left: 35, top: 100),
                  child: const Text(
                    "Create\nAccount",
                    style: TextStyle(color: Colors.black, fontSize: 33),
                  ),
                ),
                Container(
                  // width: 520,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                      right: 35,
                      left: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: name,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.account_box,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: 'Name*',
                            //labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 1.5))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: email,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: 'Email*',
                            //labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 1.5))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: password,
                        obscureText: _isVisible ? false : true,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: 'Password*',
                            //labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                updateStatus();
                              },
                              child: Icon(
                                _isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 1.5))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        obscureText: _isVisible1 ? false : true,
                        controller: repeatpassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: 'Repeat Password*',
                            //labelStyle: TextStyle(color: Colors.black87),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                updateStatus1();
                              },
                              child: Icon(
                                _isVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.green, width: 1.5))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            height: 50,
                            minWidth: 340,
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: const Text("SIGN UP"),
                            onPressed: () {
                              if (name.text == "" ||
                                  email.text == "" ||
                                  password.text == "" ||
                                  repeatpassword.text == "") {
                                Fluttertoast.showToast(
                                    msg: "Fields cannot be left blank!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    fontSize: 16.0);
                              } else if (password.text != repeatpassword.text) {
                                Fluttertoast.showToast(
                                  msg: "Both passwords must be same!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  fontSize: 16.0,
                                );
                              } else if (password.text.length < 6) {
                                Fluttertoast.showToast(
                                  msg: "Password too short!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  fontSize: 16.0,
                                );
                              } else {
                                RegistrationController().register(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text,
                                  ctx: context,
                                );
                              }
                            },
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          const Text(
                            "Already Have Account?",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff4c505b),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                                //const HomePage();
                                //const FoodApp();
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                  color: Color(0xff4c505b),
                                ),
                              )),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
