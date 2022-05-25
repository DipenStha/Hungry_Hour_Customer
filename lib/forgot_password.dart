import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/registration_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 100),
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 60),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'Enter Registered Email',
                        labelStyle: const TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
                    onChanged: (value) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        height: 50,
                        color: Colors.white,
                        minWidth: 150,
                        textColor: Colors.black,
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        splashColor: Colors.amberAccent,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        height: 50,
                        color: Colors.teal,
                        minWidth: 150,
                        textColor: Colors.white,
                        child: const Text("Verify Email"),
                        onPressed: () {
                          if (email.text == "") {
                            Fluttertoast.showToast(
                                msg: "Email Field left blank!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                textColor: Colors.white,
                                backgroundColor: Colors.red,
                                fontSize: 16.0);
                          } else {
                            ForgotPasswordController(
                                email: email.text, ctx: context);
                          }
                        },
                        splashColor: Colors.amberAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
