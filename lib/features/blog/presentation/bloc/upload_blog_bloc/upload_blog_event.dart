part of 'upload_blog_bloc.dart';

sealed class BlogEvent {}

final class BlogUploadRequested extends BlogEvent {
 final File? image;
  final String blogTitle;
  final String blogContent;
  final List<String> blogTopics;
  final DateTime uploadedAt;

  BlogUploadRequested({
    required this.blogTitle,
    required this.image,
    required this.blogContent,
    required this.blogTopics,
    required this.uploadedAt,
  });
}
