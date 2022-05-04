import 'package:flutter/material.dart';

class TakeExamScreen extends StatefulWidget {
  const TakeExamScreen({Key? key}) : super(key: key);

  @override
  State<TakeExamScreen> createState() => _TakeExamScreenState();
}

class _TakeExamScreenState extends State<TakeExamScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('take exam'),
    );
  }
}
