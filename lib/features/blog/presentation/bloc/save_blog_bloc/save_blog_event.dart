part of 'save_blog_bloc.dart';

sealed class SaveBlogEvent {}

final class SaveUnsaveBlogRequested extends SaveBlogEvent {
  String blogId;
  SaveUnsaveBlogRequested({
    required this.blogId,
  });
}


