import 'dart:async';

import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/services/exam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExamScreenViewModel extends ChangeNotifier {
  Exam _exam = Exam();
  List<QuestionModel>? questions;
  int counter = 0;
  List<String>? choices;
  int score = 0;
  Future fetchQuestions(BuildContext context, String id) async {
    try {
      questions = await _exam.fetchQuestions(id);
      prepareChoices();
      notifyListeners();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'some unkown error occured while getting the questions',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    }
  }

  checkAnswer(BuildContext context, int selectedIndex) {
    if (selectedIndex == 5) {
      //nothing is selected
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'please select one of the choices',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    }
    String selectedAnswer = choices![selectedIndex];
    if (selectedAnswer == questions![counter].correctAnswer) {
      //selected answer is true
      score++;
    }
    if (counter == questions!.length - 1) {
      //submitting the last answer. we can not increase the counter
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "you answered $score questions correctly out of ${questions!.length}",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue[600],
        duration: Duration(seconds: 3),
      ));
      Navigator.of(context).pop();
      score = 0;
      counter = 0;
      return;
    }
    counter++;
    prepareChoices();
    notifyListeners();
  }

  prepareChoices() {
    choices = [
      questions![counter].wAnswerOne,
      questions![counter].wAnswerTwo,
      questions![counter].wAnswerThree,
      questions![counter].correctAnswer
    ];
    choices!.shuffle();
  }
}
