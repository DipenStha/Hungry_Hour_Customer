import 'dart:convert';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/registration_controller.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  UserProvider? _userProvider;
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  PickedFile? imageFile;
  File? selectedFile;
  ImageProvider? _backgroundImage;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    print(this._userProvider);
    print(userProvider.getProfile().name);
    this._username.text = userProvider.getProfile().name!;
    this._email.text = userProvider.getProfile().email!;
    this._password.text = userProvider.getProfile().password ?? "";
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.orangeAccent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Badge(
                  badgeColor: Colors.black,
                  badgeContent: IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Navigator.pushNamed(context, 'pick_image');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopUpWidget(context),
                        );
                      }),
                  position: BadgePosition.topEnd(top: 80, end: -15),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        this._backgroundImage ?? AssetImage("assets/dipen.jpg"),
                    // backgroundImage: AssetImage("assets/dipen.jpg"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 520,
                  padding: EdgeInsets.only(
                      // top: MediaQuery.of(context).size.height * 0.3,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: _username,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.account_box,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: _userProvider?.getProfile().name,
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
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: _userProvider?.getProfile().email,
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
                        controller: _password,
                        obscureText: true,
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
                            child: const Text(
                              "Update",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              UpdateProfileController().update(
                                photo: "",
                                ctx: context,
                              );
                            },
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: 340,
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'main_page');
                        },
                        splashColor: Colors.redAccent,
                      ),
                      const SizedBox(
                        height: 20,
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
                Navigator.pushNamed(context, 'update_profile');
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
