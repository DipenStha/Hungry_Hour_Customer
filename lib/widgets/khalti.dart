import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/order_controller.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:khalti/khalti.dart';
import 'package:provider/provider.dart';

import 'NavigationService.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage();

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextStyle myStyle = const TextStyle(
    fontSize: 15,
    color: Colors.white,
  );
  UserProvider userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: true);
  int subtotal = 0;
  int deliveryCharge = 0;
  int? count = 0;
  bool isPasswordVisable = false;
  TextEditingController _khaltiNoController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setState(() {
      subtotal = 0;
      deliveryCharge = 0;
      this.count = userProvider.getCartFood!
          .where((element) => element.count != 0)
          .map((e) => e.restaurantId)
          .toSet()
          .toList()
          .length;
      deliveryCharge = (count ?? 0) * 100;
      userProvider.getCartFood?.forEach((element) {
        subtotal =
            subtotal + ((element.count ?? 0) * int.parse(element.price!));
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("HungryHour"),
        centerTitle: true,
        backgroundColor: Color(0xff1e213a),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 50),
            Center(
              child: Image.asset("assets/khalti.jpg", fit: BoxFit.cover),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have a Khalti account? ",
                  style: TextStyle(
                      fontFamily: "Nunito", color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Register here",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        color: Colors.green,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _khaltiNoController,
                    style: myStyle,
                    decoration: InputDecoration(
                      hintText: "Enter Khalti Number",
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      labelText: "Khalti Number",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold), //hint text style
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      fillColor: Colors.white12,
                      filled: true,
                    ),
                    validator: (value) {},
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _pinController,
                    style: myStyle,
                    keyboardType: TextInputType.number,
                    obscureText: !this.isPasswordVisable,
                    decoration: InputDecoration(
                      hintText: "Enter MPIN",
                      suffixIcon: IconButton(
                        icon: Icon(this.isPasswordVisable
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            this.isPasswordVisable =
                                this.isPasswordVisable ? false : true;
                          });
                        },
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelText: "MPIN",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold), //hint text style
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                      fillColor: Colors.white12,
                      filled: true,
                    ),
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      //print("ok");
                      final initiationModel =
                          await Khalti.service.initiatePayment(
                        request: PaymentInitiationRequestModel(
                          amount: this.subtotal +
                              (this.deliveryCharge * this.count!) * 100,
                          mobile: this._khaltiNoController.text,
                          productIdentity: 'mac-mini',
                          productName: 'Apple Mac Mini',
                          transactionPin: this._pinController.text,
                          productUrl:
                              'https://khalti.com/bazaar/mac-mini-16-512-m1',
                          additionalData: {
                            'vendor': 'Oliz Store',
                            'manufacturer': 'Apple Inc.',
                          },
                        ),
                      );
                      print(initiationModel.token);
                      final otpCode = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          String? _otp;
                          return AlertDialog(
                            title: const Text('OTP Sent!'),
                            content: TextField(
                              controller: _otpController,
                              decoration: const InputDecoration(
                                label: Text('OTP Code'),
                              ),
                              onChanged: (v) => _otp = v,
                            ),
                            actions: [
                              SimpleDialogOption(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context, _otp),
                              )
                            ],
                          );
                        },
                      );

                      if (otpCode != null) {
                        try {
                          final model = await Khalti.service
                              .confirmPayment(
                            request: PaymentConfirmationRequestModel(
                              confirmationCode: this._otpController.text,
                              token: initiationModel.token,
                              transactionPin: _pinController.text,
                            ),
                          )
                              .then((value) {
                            OrderController().createOrder(isPaid: true);
                          });

                          debugPrint(model.toString());
                        } catch (e) {
                          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 68, right: 68, top: 20, bottom: 20),
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Pay ${this.subtotal + (this.deliveryCharge * this.count!)}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 85,
                      ),
                      Text(
                        "Forgot Khalti MPIN? ",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text(
                            "Click here",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              color: Colors.green,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }
}
