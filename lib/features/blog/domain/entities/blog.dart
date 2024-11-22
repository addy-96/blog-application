class Blog {
  final String blogId;
  final String blogTitle;
  final String blogContent;
  final String blogImageUrl;
  final List<String> blogTopics;
  final DateTime updatedAt;
  final String uploaderId;

  Blog({
    required this.blogId,
    required this.blogTitle,
    required this.blogContent,
    required this.blogImageUrl,
    required this.blogTopics,
    required this.updatedAt,
    required this.uploaderId,
  });
}
