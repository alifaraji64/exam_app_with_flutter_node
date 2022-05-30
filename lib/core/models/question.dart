class QuestionModel {
  String? question, wAnswerOne, wAnswerTwo, wAnswerThree, correctAnswer;
  int? id;
  QuestionModel({
    required this.question,
    required this.wAnswerOne,
    required this.wAnswerTwo,
    required this.wAnswerThree,
    required this.correctAnswer,
    this.id,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        question: json['question'],
        wAnswerOne: json['wAnswerOne'],
        wAnswerTwo: json['wAnswerTwo'],
        wAnswerThree: json['wAnswerThree'],
        correctAnswer: json['correctAnswer'],
      );

  Map<String, String> toJson() {
    return {
      'question': question!,
      'wAnswerOne': wAnswerOne!,
      'wAnswerTwo': wAnswerTwo!,
      'wAnswerThree': wAnswerThree!,
      'correctAnswer': correctAnswer!
    };
  }
}
