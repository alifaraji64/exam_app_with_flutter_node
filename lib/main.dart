import 'package:examyy/meta/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'meta/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/': (context) => const HomeScreen(),
        '/splash_screen': (context) => const SplashScreen()
      },
    );
  }
}
