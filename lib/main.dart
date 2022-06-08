import 'package:examyy/core/services/exam.dart';
import 'package:examyy/core/services/notofications.dart';
import 'package:examyy/core/view_models/create_exam_screen_view_model.dart';
import 'package:examyy/core/view_models/exam_screen_view_model.dart';
import 'package:examyy/core/view_models/take_exam_screen_view_model.dart';
import 'package:examyy/meta/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'meta/screens/splash_screen.dart';

void callbackDispatcher() async {
  Exam _exam = Exam();
  NotificationService _notification = NotificationService();

  Workmanager().executeTask((task, inputData) async {
    print('ttt');
    if (task == 'newExamNotifier') {
      bool newExamExists = await _exam.newExamExists();
      print(newExamExists);
      if (newExamExists) {
        await _notification.initialize();
        await _notification.instantNotification();
      }
    }

    return Future.value(true);
  });
}

void main() async {
  print('lalala2');
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  await Workmanager().registerOneOffTask(
    "1",
    "newExamNotifier",
    initialDelay: const Duration(seconds: 15),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CreateExamScreenViewModel()),
        ChangeNotifierProvider(create: (context) => TakeExamScreenViewModel()),
        ChangeNotifierProvider(create: (context) => ExamScreenViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/splash_screen',
        routes: {
          '/': (context) => const HomeScreen(),
          '/splash_screen': (context) => const SplashScreen()
        },
      ),
    );
  }
}
