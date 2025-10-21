import 'package:exam/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:exam/utils/routes.dart';

void main() {
  runApp(const MyApp());
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
