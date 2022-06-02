import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/view_models/create_exam_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _orderController = TextEditingController();
  QuestionModel? _question;
  String? url;
  bool? isUploadingImage = false;
  bool? imageUploaded = false;

  @override
  Widget build(BuildContext context) {
    void _inputUpdated(String? _) {
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
                  controller: _orderController,
                  onChanged: _inputUpdated,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    if (url != null) {
                      _inputUpdated(null);
                    }
                    setState(() {
                      isUploadingImage = true;
                    });
                    try {
                      url = await Provider.of<CreateExamScreenViewModel>(
                              context,
                              listen: false)
                          .pickImage(context);
                      setState(() {
                        imageUploaded = true;
                      });
                      print(url!);
                      // ignore: empty_catches
                    } catch (e) {
                    } finally {
                      setState(() {
                        isUploadingImage = false;
                      });
                    }
                  },
                  child: isUploadingImage == false
                      ? (imageUploaded == false
                          ? const Icon(
                              Icons.image,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.check,
                              color: Colors.green,
                            ))
                      : const CircularProgressIndicator(),
                ),
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
                  onChanged: _inputUpdated,
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
                  onChanged: _inputUpdated,
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
                  onChanged: _inputUpdated,
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
                  onChanged: _inputUpdated,
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
                  correctAnswer: _correctAnswer.value.text,
                  url: url,
                  order: int.parse(_orderController.value.text),
                );
                Provider.of<CreateExamScreenViewModel>(context, listen: false)
                    .addToQuestions(context, _question!);
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
