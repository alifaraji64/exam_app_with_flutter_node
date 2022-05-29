import 'package:examyy/core/models/question.dart';
import 'package:examyy/meta/widgets/question.dart';
import 'package:flutter/cupertino.dart';

class CreateExamScreenViewModel extends ChangeNotifier {
  List<QuestionModel> questions = [];
  addToQuestions(QuestionModel _question) {
    questions.add(_question);
    notifyListeners();
  }

  bool querstionExistsInArray(QuestionModel _question) {
    var res = questions
        .where((question) => question.correctAnswer == _question.correctAnswer);
    return res.isNotEmpty;
  }
}
