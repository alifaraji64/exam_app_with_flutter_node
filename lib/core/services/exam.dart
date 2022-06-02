import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Exam {
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
      return ('https://ipfs.io/ipfs/' + jsonDecode(responsed.body)['cid']);
    } catch (e) {
      print(e);
    }
  }
}

class CustomException implements Exception {
  String? msg;
  CustomException({this.msg});
}
