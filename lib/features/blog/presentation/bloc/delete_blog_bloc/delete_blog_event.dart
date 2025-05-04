sealed class DeleteBlogEvent {}

final class DeleteBlogRequested extends DeleteBlogEvent {
  DeleteBlogRequested({required this.blogID});
  final String blogID;
}
