import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/model/get_restaurant.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  UserProvider userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: true);
  List<GetFoods> getCartFood = [];
  num subtotal = 0;
  num serviceCharge = 0;
  num deliveryCharge = 0;
  num vatAmount = 0;
  int? count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: calculation(),
      body: ListView(
        itemExtent: 150,
        children: userProvider.getFoodFromCart().length != 0
            ? userProvider.getFoodFromCart().map((e) => food(food: e)).toList()
            : [
                Container(
                  color: Colors.orangeAccent,
                  //height: 50,
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                      child: Text(
                    "No Foods in Cart!!!",
                    style: TextStyle(color: Colors.red, fontSize: 19),
                  )),
                ),
              ],
      ),
    );
  }

  Widget food({required GetFoods food}) {
    return Container(
      height: 125.0,
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
      margin: EdgeInsets.only(top: 15, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 95,
                  width: 110,
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  child: Image.asset(
                    "assets/burger.jpg",
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: Colors.red
                  ),
                ),
                Container(
                  width: 160,
                  margin: EdgeInsets.only(left: 14, top: 10, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            text: "Rs. ${food.price}          ",
                          ),
                          // WidgetSpan(
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       //print(isFav);
                          //       setState(() {
                          //         if (isFav) {
                          //           userProvider.removeFavourite(
                          //               getFoods: food);
                          //         } else {
                          //           userProvider.setFavourite(getFoods: food);

                          //           // userProvider!.removeFavourite(getFoods: food);
                          //         }
                          //       });
                          //     },
                          //     child: Icon(
                          //       isFav == false
                          //           ? Icons.favorite_outline_outlined
                          //           : Icons.favorite,
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  // width: 70,
                  margin: EdgeInsets.only(top: 8, right: 1),
                  padding: EdgeInsets.only(bottom: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            food.count = food.count! + 1;
                            if (food.count! > 0) {
                              userProvider.addToCart(getCartFood: food);
                            } else {
                              userProvider.removeFromCart(getCartFood: food);
                            }
                          });
                        },
                        child: Container(
                          height: 36,
                          width: 70,
                          // padding: EdgeInsets.only(top: 1, bottom: 1),
                          // minWidth: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepOrangeAccent,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.deepOrangeAccent,
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${food.count}",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (food.count! <= 0) {
                              userProvider.removeFromCart(getCartFood: food);
                            } else {
                              food.count = food.count! - 1;
                            }
                          });
                        },
                        child: Container(
                            height: 36,
                            width: 70,
                            //margin: EdgeInsets.only(bottom: 1),
                            // padding: EdgeInsets.only(top: 1, bottom: 1),
                            // minWidth: 50,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepOrangeAccent,
                              border: Border.all(
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            child: Center(
                              //child: Text(food.count == 0 ? "x" : "-",
                              child: Text(food.count == 0 ? "-" : "-",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                        // onPressed: () {},
                        //  splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                )
              ])
        ],
      ),
    );
    //   return Container(
    //     height: 100.0,
    //     margin: EdgeInsets.only(top: 10, bottom: 2, left: 20, right: 20),
    //     padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
    //     //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    //     child: ListTile(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //       tileColor: Colors.white,
    //       onTap: () {},
    //       isThreeLine: true,
    //       leading: Image.asset(
    //         "assets/momo.jpg",
    //         height: 80,
    //         width: 100,
    //       ),
    //       title: Text(
    //         food.name.toString(),
    //         // overflow: TextOverflow.visible,
    //         // overflow: TextOverflow.ellipsis,
    //         style: TextStyle(
    //             fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    //       ),
    //       subtitle: RichText(
    //         overflow: TextOverflow.ellipsis,
    //         text: TextSpan(children: [
    //           TextSpan(
    //             style: TextStyle(fontSize: 15, color: Colors.black),
    //             text: "Rs. ${food.price}                        ",
    //           ),
    //           // WidgetSpan(
    //           //   child: GestureDetector(
    //           //     onTap: () {
    //           //       //print(food.name);
    //           //       userProvider.removeFavourite(getFoods: food);
    //           //       setState(() {
    //           //         food.isFav = food.isFav == true ? false : true;
    //           //       });
    //           //     },
    //           //     child: Icon(
    //           //       food.isFav == false
    //           //           ? Icons.favorite
    //           //           : Icons.favorite_outline_outlined,
    //           //       color: Colors.red,
    //           //     ),
    //           //   ),
    //           // ),
    //         ]),
    //       ),
    //       trailing: Column(
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 food.count = food.count! + 1;
    //                 if (food.count! > 0) {
    //                   userProvider.addToCart(getCartFood: food);
    //                 } else {
    //                   userProvider.removeFromCart(getCartFood: food);
    //                 }
    //               });
    //             },
    //             child: Container(
    //               height: 18,
    //               width: 40,
    //               margin: EdgeInsets.only(bottom: 3.5),
    //               // padding: EdgeInsets.only(top: 1, bottom: 1),
    //               // minWidth: 50,
    //               color: Colors.blueAccent,
    //               child: Center(child: Text("+")),
    //               // onPressed: () {},
    //               // splashColor: Colors.redAccent,
    //             ),
    //           ),
    //           Text("${food.count}"),
    //           GestureDetector(
    //             onTap: () {
    //               setState(() {
    //                 if (food.count! <= 0) {
    //                   userProvider.removeFromCart(getCartFood: food);
    //                 } else {
    //                   food.count = food.count! - 1;
    //                 }
    //               });
    //             },
    //             child: Container(
    //               height: 18,
    //               width: 40,
    //               //margin: EdgeInsets.only(bottom: 1),
    //               // padding: EdgeInsets.only(top: 1, bottom: 1),
    //               // minWidth: 50,
    //               color: Colors.blueAccent,
    //               child: Center(
    //                   child: Text(
    //                 food.count == 0 ? "x" : "-",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               )),
    //               // onPressed: () {},
    //               //  splashColor: Colors.redAccent,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
  }

  Widget calculation() {
    setState(() {
      subtotal = 0;
      deliveryCharge = 0;
      serviceCharge = 0;
      vatAmount = 0;
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
        serviceCharge = (subtotal * (10 / 100));
        vatAmount = (subtotal * (13 / 100));
      });
    });

    return Container(
        height: 200.0,
        margin: EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 20),
        padding: EdgeInsets.only(top: 10.0, bottom: 5.0, right: 17, left: 17),
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        decoration: BoxDecoration(
            color: Colors.red[50], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Sub Total                                                               Rs. ${subtotal}"),
            SizedBox(
              height: 7,
            ),
            Text(
                "Delivery Charge x ${count}                                              Rs. ${this.subtotal != 0 ? deliveryCharge : 0}"),
            SizedBox(
              height: 8,
            ),
            Text(
                "Service Charge(10%)                                           Rs. ${this.subtotal != 0 ? serviceCharge.round() : 0}"),
            SizedBox(
              height: 8,
            ),
            Text(
                "VAT(13%)                                                               Rs. ${this.subtotal != 0 ? vatAmount.round() : 0}"),
            SizedBox(
              height: 8,
            ),
            Text(
                "Grand Total                                                            Rs. ${this.subtotal != 0 ? (this.subtotal + this.deliveryCharge + this.serviceCharge + this.vatAmount).round() : 0}"),
            SizedBox(
              height: 8,
            ),
            MaterialButton(
              height: 50,
              minWidth: 350,
              color: Colors.teal,
              textColor: Colors.white,
              child: const Text(
                "Check Out",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: this.subtotal > 20
                  ? () {
                      Navigator.pushNamed(context, 'stepperPage');
                    }
                  : null,
              splashColor: Colors.redAccent,
            ),
            // SizedBox(
            //   height: 8 ,
            // ),
          ],
        ));
  }
}
