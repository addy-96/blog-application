part of 'save_blog_bloc.dart';

sealed class SaveBlogState {}

final class SaveBlogInitial extends SaveBlogState {}

final class SaveUnsaveBlogLoading extends SaveBlogState {}

final class SaveBlogSuccess extends SaveBlogState {}

final class SaveBlogFailure extends SaveBlogState {
  final String errorMessage;
  SaveBlogFailure({required this.errorMessage});
}



