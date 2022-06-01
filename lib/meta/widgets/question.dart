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
  final TextEditingController _idController = TextEditingController();
  QuestionModel? _question;
  String? image;

  @override
  Widget build(BuildContext context) {
    void _inputUpdated(String _) {
      _question != null
          ? Provider.of<CreateExamScreenViewModel>(context, listen: false)
              .deleteQuestion(_question!)
          // ignore: avoid_print
          : print('wohooo');
    }

    return Container(
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.green[100],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                      ),
                      gapPadding: 4,
                    ),
                    helperText: 'order no.',
                  ),
                ),
                //flex: 1,
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.55),
              Flexible(
                flex: 1,
                child: MaterialButton(
                    onPressed: () async {
                      try {
                        //print('xxxxxx' + image!);
                        image = await Provider.of<CreateExamScreenViewModel>(
                                context,
                                listen: false)
                            .pickImage();
                        print('wowooo');
                        print(image);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.green,
                    )),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Flexible(
                child: Text('type your question',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                flex: 4,
              ),
            ],
          ),
          TextFormField(
            controller: _questionController,
            onChanged: _inputUpdated,
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
                    question: _questionController.value.text,
                    wAnswerOne: _firstWrongAnswer.value.text,
                    wAnswerTwo: _secondWrongAnswer.value.text,
                    wAnswerThree: _thirdWrongAnswer.value.text,
                    correctAnswer: _correctAnswer.value.text);
                Provider.of<CreateExamScreenViewModel>(context, listen: false)
                    .addToQuestions(_question!);
              },
              child:
                  //check if any question is pushed into the array
                  Provider.of<CreateExamScreenViewModel>(context, listen: true)
                          .questions
                          .isNotEmpty
                      //check if the pushed question exists in array=> show check mark
                      ? (Provider.of<CreateExamScreenViewModel>(context,
                                  listen: true)
                              .questions
                              .where((question) =>
                                  question.question ==
                                  (_question != null
                                      ? _question!.question
                                      : false))
                              .isNotEmpty
                          ? const Icon(Icons.check)
                          : const Text(
                              'submit this question1',
                              style: TextStyle(color: Colors.white),
                            ))
                      : const Text('submit this question'))
        ],
      ),
    );
  }
}
