class QuestionModel {
  String? wAnswerOne, wAnswerTwo, wAnswerThree, correctAnswer;
  QuestionModel({
    required this.wAnswerOne,
    required this.wAnswerTwo,
    required this.wAnswerThree,
    required this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        wAnswerOne: json['wAnswerOne'],
        wAnswerTwo: json['wAnswerTwo'],
        wAnswerThree: json['wAnswerThree'],
        correctAnswer: json['correctAnswer'],
      );

  Map<String, String> toJson() {
    return {
      'wAnswerOne': wAnswerOne!,
      'wAnswerTwo': wAnswerTwo!,
      'wAnswerThree': wAnswerThree!,
      'correctAnswer': correctAnswer!
    };
  }
}
