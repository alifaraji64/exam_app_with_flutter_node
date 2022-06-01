import 'package:file_picker/file_picker.dart';

class Exam {
  Future pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result == null) {
      return CustomException(msg: "you didn't select any image");
    }
    print(result);
    //returning the path of the selected file, so we can wrap it with File in cubit
    return result.files.single.path;
  }
}

class CustomException implements Exception {
  String? msg;
  CustomException({msg});
}
