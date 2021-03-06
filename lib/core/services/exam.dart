import 'dart:async';
import 'dart:convert';

import 'package:examyy/core/models/exam.dart';
import 'package:examyy/core/models/question.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class Exam {
  static const baseUrl =
      'https://b9b5-2a01-5ec0-7006-2716-1575-71a0-6377-ee40.ngrok.io';
  static String token = '';
  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result == null) {
      throw CustomException(msg: "you didn't select any image");
    }
    //returning the path of the selected file, so we can wrap it with File in cubit
    return result.files.single.path;
  }

  Future uploadImage(String _image) async {
    Uri url = Uri.parse('https://api.web3.storage/upload');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    });
    request.files.add(await http.MultipartFile.fromPath('file', _image));
    try {
      var res = await request.send();
      var responsed = await http.Response.fromStream(res);
      print(responsed.body);
      return ('https://ipfs.io/ipfs/' + jsonDecode(responsed.body)['cid']);
    } catch (e) {
      print('error while uploading image');
      print(e);
    }
  }

  Future postExam(
      List<QuestionModel> _questions, ExamModel _examInstance) async {
    _questions.map((q) => q.toJson());
    final client = http.Client();
    Uri uri = Uri.parse(baseUrl + '/add-exam');
    http.Response response = await client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'questions': _questions, 'exam': _examInstance.toJson()}));
    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    client.close();
  }

  Future<List<ExamModel>> fetchExams() async {
    final client = http.Client();
    Uri uri = Uri.parse(baseUrl + '/fetch-exams');
    http.Response response = await client.get(uri);

    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    client.close();
    List exams = jsonDecode(response.body)['exams'];
    List<ExamModel> convertedExams =
        exams.map((e) => ExamModel.fromJson(e)).toList();
    return convertedExams;
  }

  Future<List<QuestionModel>> fetchQuestions(String id) async {
    final client = http.Client();
    Uri uri = Uri.parse(baseUrl + '/fetch-questions');
    http.Response response = await client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'_id': id}));

    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    client.close();
    List exams = jsonDecode(response.body)['questions'];
    print(exams);
    List<QuestionModel> convertedQuestions =
        exams.map((e) => QuestionModel.fromJson(e)).toList();
    return convertedQuestions;
  }

  Future<bool> newExamExists() async {
    print('nnn');
    final client = http.Client();
    Uri uri = Uri.parse(baseUrl + '/new-exam-exists');
    http.Response response = await client.get(uri);
    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    client.close();
    bool newExamExists = jsonDecode(response.body)['thereIsNewExam'];
    print(newExamExists);
    return newExamExists;
  }
}

class CustomException implements Exception {
  String msg;
  CustomException({required this.msg});
}
