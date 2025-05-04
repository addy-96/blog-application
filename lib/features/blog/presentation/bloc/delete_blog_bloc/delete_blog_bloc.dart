import 'dart:developer';

import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/delete_blog_bloc/delete_blog_event.dart';
import 'package:blog_app/features/blog/presentation/bloc/delete_blog_bloc/delete_blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteBlogBloc extends Bloc<DeleteBlogEvent, DeleteBlogState> {
  final DeleteBlog deleteBlog;
  DeleteBlogBloc({
    required this.deleteBlog,
  }) : super(DeleteBlogInitialState()) {
    on<DeleteBlogRequested>(_onDeleteBlogRequested);
  }

  //
  void _onDeleteBlogRequested(
      DeleteBlogRequested event, Emitter<DeleteBlogState> emit) async {
    emit(DeleteBlogLoadingState());
    final response =
        await deleteBlog.call(DeleteBlogParams(blogId: event.blogID));

    response.fold(
      (l) {
        emit(DeleteBlogFailureState(errorMessage: l.message));
        log(l.message);
      },
      (r) => emit(DeleteBlogSuccessState(deleteStatus: r)),
    );
  }
}
