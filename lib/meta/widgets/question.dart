import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/view_models/create_exam_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _firstWrongAnswer = TextEditingController();
  final TextEditingController _secondWrongAnswer = TextEditingController();
  final TextEditingController _thirdWrongAnswer = TextEditingController();
  final TextEditingController _correctAnswer = TextEditingController();
  QuestionModel? _question;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.green[100],
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text('type your question',
              style: TextStyle(
                fontSize: 18,
              )),
          TextFormField(
            controller: _questionController,
          ),
          const SizedBox(
            height: 20,
          ),
          Table(
            children: [
              TableRow(children: [
                TextField(
                  controller: _firstWrongAnswer,
                  decoration: const InputDecoration(
                      helperText: '1.wrong answer',
                      prefixIcon: Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFormField(
                  controller: _secondWrongAnswer,
                  decoration: const InputDecoration(
                      helperText: '2.wrong answer',
                      prefixIcon: Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                ),
              ]),
              TableRow(children: [
                TextField(
                  controller: _thirdWrongAnswer,
                  decoration: const InputDecoration(
                      helperText: '3.wrong answer',
                      prefixIcon: Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                ),
                const SizedBox(
                  width: 5,
                ),
                TextFormField(
                  controller: _correctAnswer,
                  decoration: InputDecoration(
                      helperText: 'correct answer',
                      prefixIcon: Icon(
                        Icons.check,
                        color: Colors.green[600],
                      )),
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              color: Colors.green,
              onPressed: () {
                _question = QuestionModel(
                    wAnswerOne: _firstWrongAnswer.value.text,
                    wAnswerTwo: _secondWrongAnswer.value.text,
                    wAnswerThree: _thirdWrongAnswer.value.text,
                    correctAnswer: _correctAnswer.value.text);
                Provider.of<CreateExamScreenViewModel>(context, listen: false)
                    .addToQuestions(_question!);
              },
              child:
                  Provider.of<CreateExamScreenViewModel>(context, listen: true)
                          .questions
                          .isNotEmpty
                      ? (Provider.of<CreateExamScreenViewModel>(context,
                                  listen: true)
                              .questions
                              .where((question) =>
                                  question.correctAnswer ==
                                  (_question != null
                                      ? _question!.correctAnswer
                                      : false))
                              .isNotEmpty
                          ? const Icon(Icons.check)
                          : GestureDetector(
                              child: const Text(
                                'submit this question1',
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                print(_question);
                              },
                            ))
                      : const Text('submit this question'))
        ],
      ),
    );
  }
}
