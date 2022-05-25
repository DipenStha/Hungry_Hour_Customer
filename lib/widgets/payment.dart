import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/order_controller.dart';
import 'package:group_radio_button/group_radio_button.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<String> _status = ["Cash on delivery"];
  num subtotal = 0;
  num deliveryCharge = 0;
  int? count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment",
            style: TextStyle(fontSize: 19),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: 230,
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Please choose one payment method"),
              MaterialButton(
                height: 50,
                minWidth: 350,
                color: Colors.teal,
                textColor: Colors.white,
                child: const Text(
                  "Pay via Khalti",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "khalti_page");
                },
                splashColor: Colors.redAccent,
              ),
              MaterialButton(
                height: 50,
                minWidth: 350,
                color: Colors.teal,
                textColor: Colors.white,
                child: const Text(
                  "Cash on delivery",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  OrderController().createOrder();
                },
                splashColor: Colors.redAccent,
              ),

              // ListTile(
              //   title: Text("Cash on delivery"),
              //   leading: Radio(
              //     value: 1,
              //     groupValue: val,
              //     onChanged: (value) {
              //       setState(() {
              //         //val = value;
              //       });
              //     },
              //     activeColor: Colors.green,
              //   ),
              // ),
            ],
          ),
        ));
  }
}
