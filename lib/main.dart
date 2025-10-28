import 'package:exam/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:exam/utils/routes.dart';
import 'package:exam/provider/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      routes: {AppRoutes.homePage: (context) => BottomNavBar()},
    );
  }
}
