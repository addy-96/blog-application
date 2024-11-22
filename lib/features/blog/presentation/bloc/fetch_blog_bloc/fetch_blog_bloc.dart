import 'dart:developer';

import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_blog_event.dart';
part 'fetch_blog_state.dart';

class FetchBlogBloc extends Bloc<FetchBlogEvent, FetchBlogState> {
  final FetchBlog fetchBlog;

  FetchBlogBloc({
    required this.fetchBlog,
  }) : super(FetchBlogInitial()) {
    on<FetchBlogRequested>(_onFetchBlogRequested);
  }
  void _onFetchBlogRequested(
    FetchBlogRequested event,
    Emitter<FetchBlogState> emit,
  ) async {
    emit(FetchBlogLoading());
    log('inside fetchblog');
    final res = await fetchBlog.call(BlogParams());

    res.fold(
      (l) => emit(FetchBlogFailure(message: l.message)),
      (r) => emit(FetchblogSuccess(fetchedBlogList: r)),
    );
  }
}
