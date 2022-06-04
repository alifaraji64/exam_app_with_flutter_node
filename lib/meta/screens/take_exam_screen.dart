import 'package:examyy/core/models/exam.dart';
import 'package:examyy/core/view_models/take_exam_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TakeExamScreen extends StatefulWidget {
  const TakeExamScreen({Key? key}) : super(key: key);

  @override
  State<TakeExamScreen> createState() => _TakeExamScreenState();
}

class _TakeExamScreenState extends State<TakeExamScreen> {
  List<ExamModel>? exams;
  Future fetchExams() async {
    Provider.of<TakeExamScreenViewModel>(context, listen: false)
        .fetchExams(context)
        .then((exams) => this.exams = exams);
  }

  @override
  void initState() {
    fetchExams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onPressed: () {},
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
