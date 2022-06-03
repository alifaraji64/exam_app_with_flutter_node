import 'dart:async';
import 'dart:convert';

import 'package:examyy/core/models/question.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class Exam {
  static const baseUrl = 'http://10.0.2.2:8000';
  static String token = '';
  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result == null) {
      throw CustomException(msg: "you didn't select any image");
    }
    print(result);
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

  Future postExam(List<QuestionModel> _questions) async {
    final client = http.Client();
    Uri uri = Uri.parse(baseUrl + '/add-exam');
    http.Response response = await client.post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'questions': _questions}));
    if (response.statusCode != 200) {
      return throw CustomException(msg: jsonDecode(response.body)['error']);
    }
    client.close();
  }
}

class CustomException implements Exception {
  String msg;
  CustomException({required this.msg});
}
