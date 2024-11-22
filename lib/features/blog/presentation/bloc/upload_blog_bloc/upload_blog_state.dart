part of 'upload_blog_bloc.dart';

sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  BlogFailure({required this.message});
}

final class BlogSuccess extends BlogState {}
