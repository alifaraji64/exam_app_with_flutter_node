import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:examyy/core/view_models/take_exam_screen_view_model.dart';
import 'package:examyy/meta/screens/create_exam_screen.dart';
import 'package:examyy/meta/screens/take_exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;
  final iconList = <IconData>[Icons.create, Icons.check_box];
  final PageController homepageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: homepageController,
          children: const [TakeExamScreen(), CreateExamScreen()],
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              _bottomNavIndex = page;
            });
          },
        ),
        bottomNavigationBar: CustomNavigationBar(
          backgroundColor: Colors.green,
          currentIndex: _bottomNavIndex,
          bubbleCurve: Curves.bounceOut,
          scaleCurve: Curves.ease,
          selectedColor: Colors.blue[900],
          //unSelectedColor: constantColors.whiteColor,
          //strokeColor: constantColors.blueColor,
          scaleFactor: 0.2,
          iconSize: 32.0,
          onTap: (val) {
            _bottomNavIndex = val;
            homepageController.jumpToPage(val);
          },
          items: [
            CustomNavigationBarItem(icon: const Icon(Icons.check_box)),
            CustomNavigationBarItem(icon: const Icon(Icons.create)),
          ],
        ));
  }
}
