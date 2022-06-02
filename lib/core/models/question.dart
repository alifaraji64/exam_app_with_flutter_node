class QuestionModel {
  String? question, wAnswerOne, wAnswerTwo, wAnswerThree, correctAnswer, url;
  int? order;
  QuestionModel({
    required this.url,
    required this.question,
    required this.wAnswerOne,
    required this.wAnswerTwo,
    required this.wAnswerThree,
    required this.correctAnswer,
    required this.order,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
      question: json['question'],
      wAnswerOne: json['wAnswerOne'],
      wAnswerTwo: json['wAnswerTwo'],
      wAnswerThree: json['wAnswerThree'],
      correctAnswer: json['correctAnswer'],
      url: json['url'],
      order: json['order']);

  Map<String, String> toJson() {
    return {
      'question': question!,
      'wAnswerOne': wAnswerOne!,
      'wAnswerTwo': wAnswerTwo!,
      'wAnswerThree': wAnswerThree!,
      'correctAnswer': correctAnswer!,
      'url': url!,
      'order': order!.toString()
    };
  }
}
