import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/model/get_restaurant.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:provider/provider.dart';
import 'package:basics/date_time_basics.dart';

class RestaurantInfo extends StatefulWidget {
  RestaurantInfo({this.getRestaurant});
  GetRestaurant? getRestaurant;
  // const RestaurantInfo({Key? key}) : super(key: key);
  @override
  _RestaurantInfo createState() => _RestaurantInfo();
}

class _RestaurantInfo extends State<RestaurantInfo> {
  // ignore: prefer_final_fields
  List<Widget> _pages() {
    return widget.getRestaurant!.categories!
        .map(
          (e) => getFoods(
            foods: e.getFoods,
          ),
        )
        .toList();
  }

  // FavouriteProvider? _favProvider;
  UserProvider userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: false);

  List<String?> _title = [""];

  int index = 0;
  bool isOpen = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String _selectedText = _title.first.toString();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      this._title =
          widget.getRestaurant!.categories!.map((e) => e.name).toList();
    });

    var now = DateTime.now();

    var start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(widget.getRestaurant!.openFrom!.split(":")[0]), //hour
      int.parse(widget.getRestaurant!.openFrom!.split(":")[1]), //min
      int.parse(widget.getRestaurant!.openFrom!.split(":")[2]), //sec
    );
    var end = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(widget.getRestaurant!.closeAt!.split(":")[0]), //hour
      int.parse(widget.getRestaurant!.closeAt!.split(":")[1]), //min
      int.parse(widget.getRestaurant!.closeAt!.split(":")[2]), //sec
    );
    print(start.toString());
    print(end.toString());

    setState(() {
      if (start <= now && end >= now) {
        this.isOpen = true;
      } else {
        this.isOpen = false;
      }
    });

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.getRestaurant!.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
            // margin: const EdgeInsets.only(left: 5, right: 5),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/pokhara.jpg",
                      height: 230,
                    ),
                    Positioned(
                      top: 160,
                      right: MediaQuery.of(context).size.width / 3.0,
                      //bottom: 0.5,
                      child: Container(
                        height: 100,
                        width: 130,
                        child: Positioned(
                          // left: 8,
                          // bottom: 10,
                          child: Image.network(
                            host_public + widget.getRestaurant!.logo.toString(),
                            height: 100,
                            width: 130,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //Image.asset("assets/pokhara.jpg"),
                Text(
                  widget.getRestaurant!.name.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  widget.getRestaurant!.address.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  this.isOpen ? "Open" : "Closed",
                  style: TextStyle(color: Colors.black, fontSize: 12.0),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 500,
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: this._title.mapIndexed((index, title) {
                      return Container(
                        margin: EdgeInsets.only(right: 5),
                        child: MaterialButton(
                          elevation: 3.0,
                          //splashColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          minWidth: 30,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              print(index);
                              this.index = index;
                            });
                          },
                          child: Text(
                            title.toString(),
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                _pages().elementAt(this.index),
                SizedBox(height: 15.0),

                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.orangeAccent),
                //   height: 100,
                //   child:,
                // ),
              ],
            )),
      ),
    );
  }

  Widget getFoods({required List<GetFoods> foods}) {
    return Column(
      children: foods.length != 0
          ? foods.map((e) {
              return food(food: e);
            }).toList()
          : [],
    );
  }

  Widget food({required GetFoods food}) {
    UserProvider userProvider2 = Provider.of<UserProvider>(
        NavigationService.navigatorKey.currentContext!,
        listen: true);
    bool isFav = userProvider2
                .getFavourite()
                .where((element) => element.id == food.id)
                .length ==
            0
        ? false
        : true;
    Iterable<GetFoods>? carts =
        userProvider2.getCartFood?.where((element) => element.id == food.id);
    if (carts?.length != 0) {
      setState(() {
        food.count = carts?.first.count ?? 0;
      });
    }
    return Container(
      height: 125.0,
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 15, right: 15),
      margin: EdgeInsets.only(top: 15, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      //decoration: BoxDecoration(borderRadius: BorderRadius.)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            text: "Rs. ${food.price}          ",
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                //print(isFav);
                                setState(() {
                                  if (isFav) {
                                    userProvider.removeFavourite(
                                        getFoods: food);
                                  } else {
                                    userProvider.setFavourite(getFoods: food);

                                    // userProvider!.removeFavourite(getFoods: food);
                                  }
                                });
                              },
                              child: Icon(
                                isFav == false
                                    ? Icons.favorite_outline_outlined
                                    : Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 1,
                  ),
                  padding: EdgeInsets.only(bottom: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 14),
                        //padding: EdgeInsets.all(7),
                        height: 50,
                        width: 65,
                        child: MaterialButton(
                          elevation: 3.0,
                          height: 55,
                          minWidth: 74,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onPressed: () {
                            setState(() {
                              food.count = 1;
                            });
                            userProvider.addToCart(getCartFood: food, count: 1);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4, right: 4, top: 4),
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                          ),
                          color: Colors.white70,
                          splashColor: Colors.blue,
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       food.count = food.count! + 1;
                      //     });
                      //     userProvider.addToCart(getCartFood: food);
                      //   },
                      //   child: Container(
                      //     margin: EdgeInsets.only(top: 15),
                      //     padding: EdgeInsets.only(
                      //         left: 10, top: 7, bottom: 7, right: 10),
                      //     height: 55,
                      //     width: 70,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.deepOrangeAccent,
                      //       ),
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: Colors.white70,
                      //     ),
                      //     child: Center(
                      //       child: Icon(
                      //         Icons.shopping_cart,
                      //         color: Colors.black,
                      //       ),
                      //     ),

                      //     // child: Center(
                      //     //   child: Text(
                      //     //     "+",
                      //     //     style: TextStyle(
                      //     //       fontSize: 25,
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(("Add to Cart")),
                      SizedBox(
                        height: 2,
                      ),
                      // Text(
                      //   "${food.count}",
                      //   style: TextStyle(fontSize: 17),
                      // ),
                      // SizedBox(height: 2),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       if (food.count == 0) {
                      //         food.count = 0;
                      //       } else {
                      //         food.count = food.count! - 1;
                      //       }
                      //     });
                      //     userProvider.removeFromCart(getCartFood: food);
                      //   },
                      // child: Container(
                      //     height: 36,
                      //     width: 70,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: Colors.deepOrangeAccent,
                      //       border: Border.all(
                      //         color: Colors.deepOrangeAccent,
                      //       ),
                      //     ),
                      //     child: Center(
                      //       child: Text("-",
                      //           style: TextStyle(
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.bold,
                      //           )),
                      //     )),
                      //),
                    ],
                  ),
                )
              ])
        ],
      ),
      //padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      //   child: ListTile(
      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //     tileColor: Colors.white,
      //     onTap: () {},
      //     isThreeLine: true,
      //     leading: Container(
      //       height: 150,
      //       width: 100,
      //       child: Image.asset(
      //         "assets/momo.jpg",
      //         height: 130,
      //         width: 110,
      //         // minLeadingWidth,
      //       ),
      //     ),
      //     title: Text(
      //       food.name.toString(),

      //       // overflow: TextOverflow.visible,
      //       // overflow: TextOverflow.ellipsis,
      //       style: TextStyle(
      //           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      //     ),
      //     subtitle: RichText(
      //       overflow: TextOverflow.ellipsis,
      //       text: TextSpan(children: [
      //         TextSpan(
      //           style: TextStyle(fontSize: 15, color: Colors.black),
      //           text: "Rs. ${food.price}            ",
      //         ),
      //         WidgetSpan(
      //           child: GestureDetector(
      //             onTap: () {
      //               //print(isFav);
      //               setState(() {
      //                 if (isFav) {
      //                   userProvider.removeFavourite(getFoods: food);
      //                 } else {
      //                   userProvider.setFavourite(getFoods: food);

      //                   // userProvider!.removeFavourite(getFoods: food);
      //                 }
      //               });
      //             },
      //             child: Icon(
      //               isFav == false
      //                   ? Icons.favorite_outline_outlined
      //                   : Icons.favorite,
      //               color: Colors.red,
      //             ),
      //           ),
      //         ),
      //       ]),
      //     ),
      //     // subtitle: ElevatedButton.icon(
      //     //   onPressed: () {},
      //     //   icon: Icon(Icons.favorite),
      //     //   label: Text(
      //     //     "Rs. ${food.price}",
      //     //     //maxLines: 1,
      //     //     //overflow: TextOverflow.visible,
      //     //     //softWrap: true,
      //     //     style: TextStyle(fontSize: 15, color: Colors.black),
      //     //   ),
      //     // ),

      //     trailing: Column(
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //             setState(() {
      //               food.count = food.count! + 1;
      //             });
      //             userProvider.addToCart(getCartFood: food);
      //           },
      //           child: Container(
      //             height: 30,
      //             width: 70,
      //             margin: EdgeInsets.only(bottom: 3.5),
      //             // padding: EdgeInsets.only(top: 1, bottom: 1),
      //             // minWidth: 50,
      //             color: Colors.blueAccent,
      //             child: Center(child: Text("+")),
      //             // onPressed: () {},
      //             // splashColor: Colors.redAccent,
      //           ),
      //         ),
      //         Text("${food.count}"),
      //         GestureDetector(
      //           onTap: () {
      //             setState(() {
      //               if (food.count == 0) {
      //                 food.count = 0;
      //               } else {
      //                 food.count = food.count! - 1;
      //               }
      //             });
      //             userProvider.removeFromCart(getCartFood: food);
      //           },
      //           child: Container(
      //             height: 30,
      //             width: 70,
      //             //margin: EdgeInsets.only(bottom: 1),
      //             // padding: EdgeInsets.only(top: 1, bottom: 1),
      //             // minWidth: 50,
      //             color: Colors.blueAccent,
      //             child: Center(
      //                 child: Text(
      //               "-",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             )),
      //             // onPressed: () {},
      //             //  splashColor: Colors.redAccent,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }

  // Widget foods() {
  //   return Container(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           food(),
  //           food(),
  //           food(),
  //           food(),
  //           food(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

//   Widget food() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         color: Colors.black26,
//       ),
//       height: 500.0,
//       child: ListTile(
//         leading: Image.asset(
//           "assets/momo.jpg",
//           height: 70,
//           width: 100,
//         ),
//         title: const Text("Chicken Momo"),
//         tileColor: Colors.orangeAccent,
//         isThreeLine: true,
//         subtitle: const Text(
//           "Rs. 150",
//           style: TextStyle(color: Colors.black),
//         ),
//         trailing: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 i++;
//                 number.add(i);
//               },
//               child: Container(
//                 height: 18,
//                 width: 40,
//                 padding: const EdgeInsets.only(top: 1, bottom: 1),
//                 // minWidth: 50,
//                 color: Colors.blueAccent,
//                 // textColor: Colors.white,
//                 child: const Center(child: Text("+")),
//                 // onPressed: () {},
//                 // splashColor: Colors.redAccent,
//               ),
//             ),
//             SizedBox(height: 3),
//             Text("5"),
//             SizedBox(height: 3),
//             GestureDetector(
//               onTap: () {
//                 i--;
//                 number.add(i);
//               },
//               child: Container(
//                 height: 15,
//                 width: 40,
//                 margin: EdgeInsets.only(bottom: 5),
//                 padding: EdgeInsets.only(top: 1, bottom: 1),
//                 // minWidth: 50,
//                 color: Colors.blueAccent,
//                 // textColor: Colors.white,
//                 child: Center(
//                     child: Text(
//                   "-",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//                 // onPressed: () {},
//                 //  splashColor: Colors.redAccent,
//               ),
//             ),
//           ],
//         ),
//         //onTap: () {},
//       ),
//     );
// }
}
