import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),
        () => {Navigator.of(context).pushReplacementNamed('/')});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/splash.jpg'),
          const SizedBox(
            height: 20,
          ),
          Text(
            'welcome to examyy',
            style: TextStyle(
              color: Colors.green[400],
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'prepare your exams and people can test themselves',
            style: TextStyle(
              color: Colors.green[500],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
