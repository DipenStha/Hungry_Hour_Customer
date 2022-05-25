import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hungry_hour/controller/delivery_address_controller.dart';
import 'package:hungry_hour/model/delivery_address.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:hungry_hour/widgets/delivery_address.dart';
import 'package:hungry_hour/widgets/payment.dart';
import 'package:provider/provider.dart';

class StepperPage extends StatefulWidget {
  StepperPage({this.stepNumber, this.selectedDelivery});
  String get title => "";
  int? stepNumber;
  DeliveryAddress? selectedDelivery;

  @override
  _StepperPageState createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  bool isLogin = false;
  List<DeliveryAddress> _address = [];
  DeliveryAddress? selectedArea;
  // UserProvider _userProvider = Provider.of(NavigationService.navigatorKey.currentContext!);
  UserProvider? _userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: true);
  void initState() {
    super.initState();
    setState(() {
      _currentStep = widget.stepNumber ?? 0;
      this.selectedArea = widget.selectedDelivery;
      if (_userProvider!.profile!.id != null) {
        // _currentStep = 1;
        this.isLogin = false;
      }
    });
    setState(() {
      DeliveryAddressController().getAddress().then((value) {
        _userProvider?.setDeliveryAddress(value);

        this._address = value;
      });
    });
  }

  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      this._userProvider = Provider.of<UserProvider>(
          NavigationService.navigatorKey.currentContext!,
          listen: true);
      this._address = this._userProvider!.getDeliveryAddress();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          height: 700,
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
          margin:
              const EdgeInsets.only(top: 17, left: 20, right: 20, bottom: 17),
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Stepper(
              //controlsBuilder: ControlsWidgetBuilder(),
              steps: [
                Step(
                  state: _currentStep <= 0
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 0,
                  title: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  // isActive: false,
                  content: Text(
                    this.isLogin
                        ? "To complete your order, Please login into your exsiting account or signup"
                        : "You are alrady logged in",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Step(
                  state: _currentStep <= 1
                      ? StepState.editing
                      : StepState.complete,
                  isActive: _currentStep >= 1,
                  title: Text("Delivery Address",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  content: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialButton(
                          disabledColor: Colors.blue.withAlpha(100),
                          height: 50,
                          minWidth: 350,
                          color: Colors.teal,
                          textColor: Colors.white,
                          onPressed:
                              this._userProvider!.getDeliveryAddress().length <=
                                      7
                                  ? () {
                                      Navigator.pushNamed(
                                          context, 'deliveryaddress');
                                    }
                                  : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Add Delivery Address',
                                //textAlign: TextAlign.left,
                                style: TextStyle(
                                  //decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add)),
                            ],
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Column(
                          children: this
                              ._userProvider!
                              .getDeliveryAddress()
                              // .where((element) => element.id == 1)
                              .map(
                                (e) => Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        if (this
                                                ._userProvider
                                                ?.getSelectedAddress() ==
                                            e) {
                                          this
                                              ._userProvider
                                              ?.removeSelectedAddress();
                                        } else {
                                          // this._userProvider!.addDeliveryAddress(e);
                                          this
                                              ._userProvider
                                              ?.setSelectedAddress(e);
                                        }
                                      });
                                    },
                                    padding: EdgeInsets.only(
                                      left: 15,
                                    ),
                                    height: 70,
                                    minWidth: 400,
                                    color: this
                                                ._userProvider
                                                ?.getSelectedAddress() ==
                                            e
                                        ? Colors.teal
                                        : Colors.blueGrey,
                                    textColor: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ' ${e.firstName} \n${e.nearbyLandmark}, \n ${e.contactNumber1}',
                                          //textAlign: TextAlign.left,
                                          style: TextStyle(
                                            //decoration: TextDecoration.underline,
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        new DeliveryAddressPage(
                                                            deliveryAddress:
                                                                e)));
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            DeliveryAddressController()
                                                .deleteAddress(id: e.id!);
                                            setState(() {
                                              this
                                                  ._userProvider!
                                                  .removeDeliveryAddress(e);

                                              this._address.remove(e);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Delivery Address Deleated successfully",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  textColor: Colors.white,
                                                  backgroundColor: Colors.green,
                                                  fontSize: 18.0);
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                Step(
                  state: StepState.complete,
                  isActive: _currentStep >= 2,
                  title: Text("Payment"),
                  content: MaterialButton(
                      height: 50,
                      disabledColor: Colors.teal.shade50,
                      minWidth: 350,
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed:
                          this._userProvider?.getSelectedAddress() != null
                              ? () {
                                  Navigator.pushNamed(context, 'payment');
                                }
                              : null,
                      child: const Text(
                        'Payment',
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                          //decoration: TextDecoration.underline,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )),
                ),
              ],
              onStepTapped: (int newIndex) {
                setState(() {
                  _currentStep = newIndex;
                });
              },
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep != 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                } else if (_currentStep == 1) {}
              },
              onStepCancel: () {
                if (_currentStep != 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
            ),
          ),
        ));
  }
}
