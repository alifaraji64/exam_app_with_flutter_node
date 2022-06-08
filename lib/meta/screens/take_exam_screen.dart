import 'package:examyy/core/models/exam.dart';
import 'package:examyy/core/view_models/take_exam_screen_view_model.dart';
import 'package:examyy/meta/screens/exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

class TakeExamScreen extends StatefulWidget {
  const TakeExamScreen({Key? key}) : super(key: key);

  @override
  State<TakeExamScreen> createState() => _TakeExamScreenState();
}

class _TakeExamScreenState extends State<TakeExamScreen> {
  List<ExamModel>? exams;
  Future fetchExams() async {
    await Provider.of<TakeExamScreenViewModel>(context, listen: false)
        .fetchExams(context)
        .then((exams) {
      setState(() {
        this.exams = exams;
        print(exams);
      });
    });
  }

  @override
  void initState() {
    fetchExams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('O'),
        onPressed: () async {
          try {
            await Workmanager().cancelAll();
            print('Cancel all tasks completed');
          } catch (e) {
            print(e);
          }
        },
      ),
      appBar: AppBar(
        title: const Text('Take Exam'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (exams != null)
                for (var exam in exams!)
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              exam.category,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(exam.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.login,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: ((context) => ExamScreen(
                                      id: exam.id!,
                                      title: exam.name,
                                    ))));
                          },
                        )
                      ],
                    ),
                  )
            ],
          ),
        ),
      )),
    );
  }
}
