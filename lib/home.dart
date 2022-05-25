// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/ip.dart';
import 'package:hungry_hour/controller/restaurant_controller.dart';
import 'package:hungry_hour/model/restaurant.dart';
import 'package:hungry_hour/widgets/cart.dart';
import 'package:hungry_hour/widgets/update_profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FoodApp(),
    );
  }
}

class FoodApp extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;

  const FoodApp({
    Key? key,
    this.data,
    this.onTap,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  _FoodAppState createState() => _FoodAppState();
}

class _FoodAppState extends State<FoodApp> {
  TextEditingController search = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];
  //List<dynamic> responseList = restaurantData;
  List<Widget> listItems = [];
  List<Restaurant> resturestList = [];
  bool isOpen = true;
  // late FirebaseMessaging messaging;

  // ignore: prefer_typing_uninitialized_variables
  @override
  void initState() {
    super.initState();
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   print(value);
    // });

    RestaurantController().restaurants().then((value) {
      setState(() {
        resturestList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new Cart())); //Cart();
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orangeAccent,
      body: getBody(),
    );
  }

//  Widget getBody() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Let's eat \nOrder your food now",
//             style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 1, right: 1),
//             width: double.infinity,
//             height: 40.0,
//             decoration: BoxDecoration(
//                 color: Colors.orangeAccent,
//                 borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: "Search foods",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     contentPadding: const EdgeInsets.only(left: 15.0),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 1.0,
//                 ),
//                 MaterialButton(
//                     elevation: 3.0,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0)),
//                     onPressed: () {},
//                     splashColor: Colors.blueAccent,
//                     child: const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 6.0),
//                       child: Icon(
//                         Icons.search,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     color: Colors.white70),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           const Text(
//             "Featured Restaurants",
//             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 15.0,
//           ),
//         ],
//       ),
//     );
//   }
// }

  getBody() {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Let's eat \nOrder your food now",
              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 1, right: 1),
              // width: double.infinity,
              height: 40.0,

              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Search foods",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.only(left: 15.0),
                    ),
                  )),
                  const SizedBox(
                    width: 1.0,
                  ),
                  MaterialButton(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () {
                      RestaurantController()
                          .restaurants(name: this.search.text)
                          .then((value) {
                        setState(() {
                          this.resturestList = value;
                        });
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                    ),
                    color: Colors.white70,
                    splashColor: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text(
              "Featured Restaurants",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: resturestList.length == 0
                    ? [
                        Center(
                          widthFactor: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ]
                    : resturestList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              RestaurantController()
                                  .restaurant(ctx: context, id: e.id!);
                            },
                            child: Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                //margin: const EdgeInsets.only(right: 1),
                                // width: double.infinity,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: StreamBuilder<CupertinoSlider>(
                                    stream: null,
                                    builder: (context, snapshot) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0)),
                                          Image.network(
                                            host_public + e.logo.toString(),
                                            height: 90,
                                            width: 100,
                                          ),
                                          const SizedBox(width: 15.0),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 11.0)),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        e.name.toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        softWrap: true,
                                                        // overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  e.address.toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                const Text(
                                                  "_________________________________",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent),
                                                ),
                                                Container(
                                                    //width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 1.0,
                                                            right: 1,
                                                            left: 1),
                                                    //alignment: Alignment.bottomRight,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 6.0),
                                                    height: 25.0,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 177.0,
                                                        ),
                                                        Text(
                                                          this.isOpen
                                                              ? "Open"
                                                              : "Close",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
