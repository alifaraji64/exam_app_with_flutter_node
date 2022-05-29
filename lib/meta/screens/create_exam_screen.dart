import 'package:examyy/core/view_models/create_exam_screen_view_model.dart';
import 'package:examyy/meta/widgets/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreateExamScreen extends StatefulWidget {
  const CreateExamScreen({Key? key}) : super(key: key);

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  Object selectedValue = 'Item 1';
  final TextEditingController _questionNumberController =
      TextEditingController();
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Provider.of<CreateExamScreenViewModel>(context, listen: false)
              .questions
              .last
              .correctAnswer);
        },
      ),
      appBar: AppBar(
        title: const Text('Create Exam'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 10),
            const Text(
              'select the category of your exam',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton(
              value: selectedValue,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'how many questions you got for this exam?',
              style: TextStyle(fontSize: 16),
            ),
            TextFormField(
              controller: _questionNumberController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                setState(() {
                  _questionNumberController.text = value;
                });
              },
            ),
            for (int i = 0;
                i <
                    (_questionNumberController.text.isNotEmpty
                        ? int.parse(_questionNumberController.text)
                        : 0);
                i++)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Question(),
              )
          ]),
        ),
      )),
    );
  }
}
