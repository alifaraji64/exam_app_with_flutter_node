import 'package:examyy/core/models/question.dart';
import 'package:examyy/core/view_models/exam_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  final String title, id;
  const ExamScreen({Key? key, required this.title, required this.id})
      : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int? selected = 5;
  Future fetchQuestions() async {
    await Provider.of<ExamScreenViewModel>(context, listen: false)
        .fetchQuestions(context, widget.id);
  }

  @override
  void initState() {
    fetchQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<QuestionModel>? questions =
        Provider.of<ExamScreenViewModel>(context, listen: true).questions;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: questions != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.symmetric(),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              questions[Provider.of<ExamScreenViewModel>(
                                          context,
                                          listen: false)
                                      .counter]
                                  .question,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: Provider.of<ExamScreenViewModel>(
                                        context,
                                        listen: true)
                                    .choices!
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ChoiceChip(
                                    label: Text(
                                        Provider.of<ExamScreenViewModel>(
                                                context,
                                                listen: false)
                                            .choices![index]),
                                    selected: selected == index,
                                    selectedColor: Colors.green,
                                    labelStyle: TextStyle(
                                        color: selected != index
                                            ? Colors.green
                                            : Colors.white),
                                    backgroundColor: Colors.white,
                                    onSelected: (bool value) {
                                      setState(() {
                                        selected = value ? index : null;
                                      });
                                    },
                                  );
                                })
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      MaterialButton(
                        onPressed: () {
                          Provider.of<ExamScreenViewModel>(context,
                                  listen: false)
                              .checkAnswer(context, selected!);
                          selected = 5;
                        },
                        child: const Text(
                          'Submit Answer',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                      )
                    ],
                  )
                : null),
      )),
    );
  }
}
