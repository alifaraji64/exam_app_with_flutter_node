import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/services/exam.dart';
import 'package:flutter/cupertino.dart';

class CreateExamScreenViewModel extends ChangeNotifier {
  List<QuestionModel> questions = [];
  final Exam _exam = Exam();
  addToQuestions(QuestionModel _question) {
    questions.add(_question);
    notifyListeners();
  }

  bool querstionExistsInArray(QuestionModel _question) {
    var res =
        questions.where((question) => question.question == _question.question);
    return res.isNotEmpty;
  }

  deleteQuestion(QuestionModel _question) {
    print(_question.correctAnswer);
    questions
        .removeWhere((question) => question.question == _question.question);
    notifyListeners();
  }

  pickImage() async {
    try {
      String image = await _exam.pickImage();
      return image;
    } catch (e) {
      print('error occured');
      print(e);
    }
  }
}
