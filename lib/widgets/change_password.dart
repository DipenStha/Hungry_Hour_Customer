import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _oldpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
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
                    radius: 100,
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
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _newpassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'New Password*',
                        //labelStyle: TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: _confirmpassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        labelText: 'Confirm Password*',
                        //labelStyle: TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.5))),
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
