import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/display_saved_blogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'display_saved_blogs_event.dart';
part 'display_saved_blogs_state.dart';

class DisplaySavedBlogsBloc
    extends Bloc<DisplaySavedBlogsEvent, DisplaySavedBlogsState> {
  final DisplaySavedBlogs displaySavedBlogs;
  DisplaySavedBlogsBloc({
    required this.displaySavedBlogs,
  }) : super(DisplaySavedBlogsInitialState()) {
    on<DisplaySavedBlogsRequested>(_onDisplaySavedBlogsRequested);
  }

  //
  void _onDisplaySavedBlogsRequested(
    DisplaySavedBlogsRequested event,
    Emitter<DisplaySavedBlogsState> emit,
  ) async {
    emit(DisplaySavedBlogsLoadingState());
    final response = await displaySavedBlogs.call(NoParams());

    response.fold(
      (l) => emit(DispalySavedBlogsFailureState(errorMessage: l.message)),
      (r) => emit(DisplaySavedBlogsSuccessState(blogList: r)),
    );
  }
}
