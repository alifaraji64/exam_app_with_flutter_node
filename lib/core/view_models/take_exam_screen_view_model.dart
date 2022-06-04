import 'package:examyy/core/models/exam.dart';
import 'package:examyy/core/services/exam.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TakeExamScreenViewModel extends ChangeNotifier {
  Exam _exam = Exam();
  Future fetchExams(BuildContext context) async {
    try {
      List<ExamModel> exams = await _exam.fetchExams();
      return exams;
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.msg,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'some unkown error occured while getting the exams',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    }
  }
}
