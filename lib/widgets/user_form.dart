//import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:hungry_hour/widgets/change_password.dart';
import 'package:provider/provider.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  // var phoneNumber = ["9846906865"];
  PickedFile? imageFile;
  File? selectedFile;
  ImageProvider? _backgroundImage;
  // UserProvider? _photo
  // File? _image;
  // Future getImage(ImageSource source) async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (_image == null) return;
  //   final imageTemporary = File(_image.path);
  //   setState(() {
  //     _image = imageTemporary;
  //   });
  // }

  Widget smallImg(BuildContext context) => Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Spacer(),
            //_image != null ?
            ClipOval(
              child: Image.asset(
                userProvider!.profile!.photo ?? "assets/profile.jpg",
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            )
          ]),
        ),
      );
  UserProvider? userProvider;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    print(userProvider.getProfile().name);
    this._username.text = userProvider.getProfile().name!;
    this._email.text = userProvider.getProfile().email!;
    // this._photo.text = userProvider.getProfile().photo!;
    //this._password.text = userProvider.getProfile().password!;

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              // width: 520,
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  CircleAvatar(
                      radius: 80,
                      // backgroundImage: this._backgroundImage,
                      backgroundImage: AssetImage("assets/dipen.jpg")
                      //  AssetImage("assets/profile.jpg"),
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextField(
                  //   controller: _username,
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(
                  //         Icons.account_box,
                  //       ),
                  //       fillColor: Colors.grey.shade100,
                  //       filled: true,
                  //       labelText: 'Name',
                  //       labelStyle: const TextStyle(color: Colors.black),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: Colors.green, width: 1.5))),
                  //   onChanged: (value) {},
                  // ),
                  SizedBox(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Name: " + _username.text,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Email: " + _email.text,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Password:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, 'change_password');
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new ChangePassword()));
                        },
                        child: const Text(
                          '******',
                          style: TextStyle(
                            // decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   child: IconButton(
                  //       icon: const Icon(
                  //         Icons.call,
                  //       ),
                  //       onPressed: () {
                  //         launch("tel:// 9846906865");
                  //       }),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text(
                  //       "Contact Us:",
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     TextButton(
                  //         onPressed: () {
                  //           launch("tel://9846906865");
                  //         },
                  //         child: const Text(
                  //           '9846906865',
                  //           style: TextStyle(
                  //             decoration: TextDecoration.underline,
                  //             fontSize: 16,
                  //             color: Colors.black,
                  //           ),
                  //         )),
                  //   ],
                  // ),
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, 'order_history');
                  //     },
                  //     child: const Text(
                  //       'Order History',
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 16,
                  //         color: Colors.black,
                  //       ),
                  //     )),
                  // TextField(
                  //   controller: _email,
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(
                  //         Icons.email,
                  //       ),
                  //       fillColor: Colors.grey.shade100,
                  //       filled: true,
                  //       labelText: 'Email',
                  //       labelStyle: const TextStyle(color: Colors.black),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: Colors.green, width: 1.5))),
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  // TextField(
                  //   controller: _password,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(
                  //         Icons.lock,
                  //       ),
                  //       fillColor: Colors.grey.shade100,
                  //       filled: true,
                  //       labelText: 'Password',
                  //       labelStyle: const TextStyle(color: Colors.green),
                  //       border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //       focusedBorder: const OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(color: Colors.green, width: 1.5))),
                  //   onChanged: (value) {},
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25),
                    child: Row(
                      children: [
                        MaterialButton(
                            color: Colors.teal,
                            height: 50,
                            minWidth: 100.0,
                            splashColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Text(
                              "Update Profile",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {
                              // var bytes = File(this.selectedFile!.path)
                              //     .readAsBytesSync();
                              // String base64Image = base64Encode(bytes);
                              // print('upload proccess started');
                              // print(base64Image);
                              Navigator.pushNamed(context, 'update_profile');
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        MaterialButton(
                            color: Colors.teal,
                            height: 50,
                            minWidth: 140.0,
                            splashColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Text(
                              "Log Out",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpWidget(BuildContext context) {
    return new AlertDialog(
      content: Container(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              height: 50.0,
              minWidth: 160.0,
              color: Colors.greenAccent,
              onPressed: () {
                _getFromGallery();
              },
              child:
                  Text("Choose from gallery", style: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 15.0,
            ),
            MaterialButton(
              height: 50.0,
              minWidth: 170.0,
              color: Colors.lightGreenAccent,
              splashColor: Colors.greenAccent,
              onPressed: () {
                _getFromCamera();
              },
              child: Text("Take Photo", style: TextStyle(fontSize: 15)),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              height: 50.0,
              minWidth: 170.0,
              color: Colors.red,
              splashColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, 'user_form');
              },
              child: Text("Cancel", style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        // imageFile = File(pickedFile.path);
        imageFile = pickedFile;
        this.selectedFile = File(pickedFile.path);
        this._backgroundImage = FileImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        // imageFile = File(pickedFile.path);
        imageFile = pickedFile;
        this.selectedFile = File(pickedFile.path);

        this._backgroundImage = FileImage(File(pickedFile.path));
      });
    }
  }
}
