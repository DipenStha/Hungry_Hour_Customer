import 'package:flutter/material.dart';
import 'package:hungry_hour/controller/order_controller.dart';
import 'package:hungry_hour/forgot_password.dart';
import 'package:hungry_hour/home.dart';
import 'package:hungry_hour/main_page.dart';
import 'package:hungry_hour/provider/user_provider.dart';
import 'package:hungry_hour/widgets/NavigationService.dart';
import 'package:hungry_hour/widgets/cart.dart';
import 'package:hungry_hour/widgets/change_password.dart';
import 'package:hungry_hour/widgets/khalti.dart';
import 'package:hungry_hour/widgets/payment.dart';
import 'package:hungry_hour/widgets/update_profile.dart';
import 'package:hungry_hour/widgets/user_form.dart';
import 'package:hungry_hour/restaurant_info.dart';
import 'package:hungry_hour/widgets/delivery_address.dart';
import 'package:hungry_hour/widgets/food_items.dart';
import 'package:hungry_hour/widgets/stepper_form.dart';
import 'package:khalti/khalti.dart';
import 'package:provider/provider.dart';
import 'model/profile.dart';
import 'register.dart';
import 'login.dart';
import 'email_authentication.dart';

//import 'home.dart';
// Future<void> _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification!.body}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_messageHandler);

  await Khalti.init(
    publicKey: 'test_public_key_c3a61dffc8904fde95629c73cd86b77c',
    enabledDebugging: false,
  );
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => UserProvider()),
        // ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        // ChangeNotifierProvider.value(value: FavouriteProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey, // set property
        debugShowCheckedModeBanner: false,
        // initialRoute: 'food_items',
        // initialRoute: 'restaurantinfo',
        // initialRoute: 'pick_image',
        //initialRoute: 'stepperpage',
        // initialRoute: 'user_form',
        // initialRoute: 'deliveryaddress',
        initialRoute: 'login',
        // initialRoute: 'register',
        // initialRoute: 'email_authentication',
        routes: {
          'login': (context) => const MyLogin(),
          'stepperPage': (context) => StepperPage(
              // stepNumber: 2,
              ),
          'register': (context) => const MyRegister(),
          'email_authentication': (context) => const OTPVerificationPage(),
          'homePage': (context) => HomePage(),
          'user_form': (context) => User(),
          'restaurantinfo': (context) => RestaurantInfo(),
          'deliveryaddress': (context) => DeliveryAddressPage(),
          'main_page': (context) => MainPage(),
          'food_items': (context) => FoodItems(),
          'update_profile': (context) => UpdateProfile(),
          'change_password': (context) => ChangePassword(),
          'forgot_password': (context) => ForgotPassword(),
          'cart': (context) => Cart(),
          'payment': (context) => Payment(),
          'khalti_page': (context) => PaymentPage(),
          //'stepperPage': (context) => StepperPage(),
        },
      ),
    ),
  );
}
