import 'dart:io';

import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_blog_event.dart';
part 'upload_blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  BlogBloc({
    required this.uploadBlog,
  }) : super(BlogInitial()) {
    //
    on<BlogUploadRequested>(_onBlogUploadedRequested);
  }

  void _onBlogUploadedRequested(
    BlogUploadRequested event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());

    final res = await uploadBlog(
      BlogParams(
        blogTitle: event.blogTitle,
        blogContent: event.blogContent,
        blogtopics: event.blogTopics,
        uploadedAt: event.uploadedAt,
        image: event.image,
      ),
    );
    res.fold(
      (l) => BlogFailure(message: l.message),
      (r) => emit(BlogSuccess()),
    );
  }
}
