//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/area_controller.dart';
import 'package:hungry_hour/controller/delivery_address_controller.dart';
import 'package:hungry_hour/model/delivery_address.dart' as Delivery;
import 'package:hungry_hour/model/get_area.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:hungry_hour/widgets/stepper_form.dart';
import 'package:provider/provider.dart';

class DeliveryAddressPage extends StatefulWidget {
  DeliveryAddressPage({this.deliveryAddress});

  Delivery.DeliveryAddress? deliveryAddress;

  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController cNumber1 = TextEditingController();
  TextEditingController cNumber2 = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController houseNo = TextEditingController();
  TextEditingController nearbyLandmark = TextEditingController();
  List<Area> areas = [];
  Area? selectedArea;
  List<DropdownMenuItem<Area>> dropDownItems = [];

  @override
  void initState() {
    // TODO: implement initState
    AreaController.areas().then((value) {
      setState(() {
        this.fName.text = widget.deliveryAddress?.firstName ?? "";
        this.lName.text = widget.deliveryAddress?.lastName ?? "";
        this.cNumber1.text = widget.deliveryAddress?.contactNumber1 ?? "";
        this.cNumber2.text = widget.deliveryAddress?.contactNumber2 ?? "";
        this.street.text = widget.deliveryAddress?.street ?? "";
        this.houseNo.text = widget.deliveryAddress?.houseNo ?? "";
        this.nearbyLandmark.text = widget.deliveryAddress?.nearbyLandmark ?? "";
        this.areas = value;
        try {
          String? areaid = widget.deliveryAddress?.areasId;

          this.selectedArea = this
              .areas
              .singleWhere((element) => element.id == int.parse(areaid!));
        } catch ($e) {
          this.selectedArea = value.first;
        }
      });
      setState(() {
        this.areas.map((e) {
          setState(() {
            DropdownMenuItem<Area>(child: Text(e.areaName.toString()));
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          height: 700,
          //margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            //borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                controller: fName,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'First Name *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              TextField(
                controller: lName,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'Last Name *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),

              TextField(
                controller: cNumber1,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'Contact Number 1 *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),

              TextField(
                controller: cNumber2,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'Contact Number 2',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),

              Container(
                padding: EdgeInsets.only(left: 80),
                width: 500,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                child: DropdownButton<Area>(
                    value: this.selectedArea,
                    onTap: () {},
                    items: this
                        .areas
                        .map((e) => DropdownMenuItem<Area>(
                            value: e, child: Text(e.areaName.toString())))
                        .toList(),
                    onChanged: (e) {
                      setState(() {
                        this.selectedArea = e;
                      });
                    }),
              ),
              TextField(
                controller: street,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'Street/Tole',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),

              TextField(
                controller: houseNo,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'House No.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),

              TextField(
                controller: nearbyLandmark,
                decoration: InputDecoration(
                    // prefixIcon: const Icon(
                    //   Icons.text_fields,
                    // ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    labelText: 'Nearby Landmark *',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (value) {},
              ),
              // SizedBox()
              MaterialButton(
                height: 50,
                minWidth: 150,
                color: Colors.teal,
                textColor: Colors.white,
                child:
                    Text(widget.deliveryAddress == null ? " Save" : "Update"),
                onPressed: () {
                  if (fName.text == "" ||
                      lName.text == "" ||
                      cNumber1.text == "" ||
                      nearbyLandmark.text == "") {
                    Fluttertoast.showToast(
                        msg: "Fields with * must be filled",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        fontSize: 16.0,
                        backgroundColor: Colors.redAccent);
                  } else {
                    DeliveryAddressController().register(
                      id: widget.deliveryAddress != null
                          ? widget.deliveryAddress?.id
                          : 0,
                      firstName: fName.text,
                      lastName: lName.text,
                      contactNumber1: cNumber1.text,
                      contactNumber2: cNumber2.text,
                      areasId: selectedArea!.id.toString(),
                      street: street.text,
                      houseNo: houseNo.text,
                      nearbyLandmark: nearbyLandmark.text,
                      ctx: context,
                    );
                    Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new StepperPage(
                            stepNumber: 0,
                          ),
                        ));
                  }
                },
                splashColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
