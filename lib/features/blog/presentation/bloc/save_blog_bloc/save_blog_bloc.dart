import 'package:blog_app/features/blog/domain/usecases/save_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'save_blog_event.dart';
part 'save_blog_state.dart';

class SaveBlogBloc extends Bloc<SaveBlogEvent, SaveBlogState> {
  final SaveBlog saveBlog;

  SaveBlogBloc({
    required this.saveBlog,
  }) : super(SaveBlogInitial()) {
    //
    on<SaveUnsaveBlogRequested>(_onSaveUnsaveBlogRequested);
  }

  //
  void _onSaveUnsaveBlogRequested(
    SaveUnsaveBlogRequested event,
    Emitter<SaveBlogState> emit,
  ) async {
    emit(SaveUnsaveBlogLoading());
    final res = await saveBlog.call(
      SaveBlogParams(
        blogId: event.blogId,
      ),
    );

    res.fold(
      (l) => emit(SaveBlogFailure(
        errorMessage: l.message,
      )),
      (r) => emit(SaveBlogSuccess()),
    );
  }

  //

}
