import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'package:email_auth/email_auth.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OTPVerificationPage(),
  ));
}

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");

  void sendOtp() async {
    var result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 5);
    if (result) {
      // ignore: avoid_print
      print("OTP sent");
    } else {
      // ignore: avoid_print
      print("We could not sent the OTP");
    }
  }

  void verifyOtp() {
    var result = emailAuth.validateOtp(
        recipientMail: _emailController.text, userOtp: _otpController.text);
    if (result) {
      // ignore: avoid_print
      print("OTP Verified");
    } else {
      // ignore: avoid_print
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.orangeAccent,
          body: Stack(
            children: [
              Container(
                width: 520,
                padding: const EdgeInsets.only(left: 35, top: 10),
                child: const Text(
                  "Email\nVerification",
                  style: TextStyle(color: Colors.black, fontSize: 33),
                ),
              ),
              Container(
                width: 520,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.3,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Enter Email',
                        suffixIcon: MaterialButton(
                          child: const Text(
                            "Send OTP",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onPressed: () => sendOtp(),
                          splashColor: Colors.blueAccent,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      controller: _otpController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'OTP',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: 340,
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(context, 'homePage');
                      },
                      child: const Text("Verify OTP",
                          style: TextStyle(
                            height: 2.5,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
