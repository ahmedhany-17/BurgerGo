//import 'package:burgergo/cart/cart.dart';
import 'package:burgergo/cart/cart_provider.dart';
//import 'package:burgergo/home/home.dart';
import 'package:burgergo/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
      home: SplashView(),
      // routes: {
      //   '/home': (context) => Home(),
      //   '/cart': (context) => CartPage(),
      // },
    );
  }
}
