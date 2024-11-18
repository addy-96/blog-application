import 'dart:io';
import 'package:blog_app/core/utils/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogImageCubit extends Cubit<File?> {
  BlogImageCubit() : super(null);

  void selectImage() async{
        final selectedImage = await pickImage(); // Wait for the Future to complete
    emit(selectedImage);
  }
}
