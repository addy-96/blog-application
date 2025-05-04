part of 'fetch_blog_bloc.dart';

sealed class FetchBlogState {}

final class FetchBlogInitial extends FetchBlogState {}

final class FetchBlogLoading extends FetchBlogState {}

final class FetchBlogFailure extends FetchBlogState {
  final String message;

  FetchBlogFailure({
    required this.message,
  });
}

final class FetchblogSuccess extends FetchBlogState {
  final Future<List<Blog>> fetchedBlogList;

  FetchblogSuccess({
    required this.fetchedBlogList,
  });
}
