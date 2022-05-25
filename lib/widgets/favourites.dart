import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/model/get_restaurant.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  UserProvider userProvider = Provider.of<UserProvider>(
      NavigationService.navigatorKey.currentContext!,
      listen: true);
  List<GetFoods> getFoods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites", style: TextStyle(fontSize: 19)),
        centerTitle: true,
      ),
      body: ListView(
        itemExtent: 150,
        children: userProvider.getFavourite().length != 0
            ? userProvider.getFavourite().map((e) => food(food: e)).toList()
            : [
                Container(
                  //height: 100,
                  //color: Colors.orangeAccent,
                  margin: EdgeInsets.only(top: 100),
                  child: Center(
                      child: Text(
                    "No favourite food selected!!!",
                    style: TextStyle(color: Colors.red, fontSize: 19),
                  )),
                )
              ],
      ),
    );
  }

  Widget food({required GetFoods food}) {
    return Container(
      height: 125.0,
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
      margin: EdgeInsets.only(top: 15, bottom: 5, left: 10, right: 10),
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
                  margin: EdgeInsets.only(left: 14, top: 10, right: 1),
                  width: 170,
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
                                //print(food.name);
                                userProvider.removeFavourite(getFoods: food);
                                setState(() {
                                  food.isFav =
                                      food.isFav == true ? false : true;
                                });
                              },
                              child: Icon(
                                food.isFav == false
                                    ? Icons.favorite
                                    : Icons.favorite_outline_outlined,
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
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.only(bottom: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            food.count = food.count! + 1;
                          });
                          userProvider.addToCart(getCartFood: food);
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
                            if (food.count == 0) {
                              food.count = 0;
                            } else {
                              food.count = food.count! - 1;
                            }
                          });
                          userProvider.removeFromCart(getCartFood: food);
                        },
                        child: Container(
                            height: 36,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.deepOrangeAccent,
                              border: Border.all(
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            child: Center(
                              child: Text("-",
                                  style: TextStyle(
                                    fontSize: 30,
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
    //     margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
    //     // padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
    //     //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    //     child: SizedBox(
    //       height: 110,
    //       child: ListTile(
    //         // dense: true,
    //         shape:
    //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //         tileColor: Colors.white,
    //         onTap: () {},
    //         isThreeLine: true,
    //         leading: Image.asset(
    //           "assets/momo.jpg",
    //           height: 80,
    //           width: 100,
    //         ),
    //         title: Text(
    //           food.name.toString(),
    //           // overflow: TextOverflow.visible,
    //           // overflow: TextOverflow.ellipsis,
    //           style: TextStyle(
    //               fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    //         ),
    //         subtitle: RichText(
    //           overflow: TextOverflow.ellipsis,
    //           text: TextSpan(children: [
    //             TextSpan(
    //               style: TextStyle(fontSize: 15, color: Colors.black),
    //               text: "Rs. ${food.price}                        ",
    //             ),
    //             WidgetSpan(
    //               child: GestureDetector(
    //                 onTap: () {
    //                   //print(food.name);
    //                   userProvider.removeFavourite(getFoods: food);
    //                   setState(() {
    //                     food.isFav = food.isFav == true ? false : true;
    //                   });
    //                 },
    //                 child: Icon(
    //                   food.isFav == false
    //                       ? Icons.favorite
    //                       : Icons.favorite_outline_outlined,
    //                   color: Colors.red,
    //                 ),
    //               ),
    //             ),
    //           ]),
    //         ),
    //         trailing: Column(
    //           children: [
    //             GestureDetector(
    //               onTap: () {
    //                 userProvider.addToCart(getCartFood: food);
    //                 setState(() {
    //                   food.count = food.count! + 1;
    //                 });
    //               },
    //               child: Container(
    //                 height: 18,
    //                 width: 40,
    //                 margin: EdgeInsets.only(bottom: 3.5),
    //                 // padding: EdgeInsets.only(top: 1, bottom: 1),
    //                 // minWidth: 50,
    //                 color: Colors.blueAccent,
    //                 child: Center(child: Text("+")),
    //                 // onPressed: () {},
    //                 // splashColor: Colors.redAccent,
    //               ),
    //             ),
    //             Text("${food.count}"),
    //             GestureDetector(
    //               onTap: () {
    //                 setState(() {
    //                   if (food.count == 0) {
    //                     food.count = 0;
    //                     userProvider.removeFromCart(getCartFood: food);
    //                   } else {
    //                     food.count = food.count! - 1;
    //                   }
    //                 });
    //               },
    //               child: Container(
    //                 height: 18,
    //                 width: 40,
    //                 //margin: EdgeInsets.only(bottom: 1),
    //                 // padding: EdgeInsets.only(top: 1, bottom: 1),
    //                 // minWidth: 50,
    //                 color: Colors.blueAccent,
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
    //       ),
    //     ),
    //   );
  }
}
