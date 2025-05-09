import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedimage != null) {
      return File(pickedimage.path);
    }

    return null;
  } catch (err) {
    return null;
  }
}
