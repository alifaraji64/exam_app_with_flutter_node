import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/services/exam.dart';
import 'package:flutter/material.dart';

class CreateExamScreenViewModel extends ChangeNotifier {
  List<QuestionModel> questions = [];
  final Exam _exam = Exam();
  addToQuestions(BuildContext context, QuestionModel _question) {
    if (_question.correctAnswer!.isEmpty ||
        _question.question!.isEmpty ||
        _question.wAnswerOne!.isEmpty ||
        _question.wAnswerTwo!.isEmpty ||
        _question.wAnswerThree!.isEmpty ||
        _question.order!.bitLength <= 0) {
      print('1');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'please fill all the fields. only image is optional',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
      return;
    }
    print('2');
    print(_question.correctAnswer);
    questions.add(_question);
    notifyListeners();
  }

  deleteQuestion(QuestionModel _question) {
    print(_question.correctAnswer);
    questions
        .removeWhere((question) => question.question == _question.question);
    notifyListeners();
  }

  pickImage(BuildContext context) async {
    try {
      String image = await _exam.pickImage();
      String url = await uploadImage(context, image);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'image uploaded successfully',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green[600],
      ));
      return url;
    } on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.msg!.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'an unknown error occured',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    }
  }

  uploadImage(BuildContext context, String _image) async {
    try {
      return await _exam.uploadImage(_image);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'an unknown error occured',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[600],
      ));
    }
  }
}
