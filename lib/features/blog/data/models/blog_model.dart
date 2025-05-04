import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.blogId,
    required super.blogTitle,
    required super.blogContent,
    required super.blogImageUrl,
    required super.blogTopics,
    required super.updatedAt,
    required super.uploaderId,
  });

/*   @override
  String toString() {
    return 'BlogModel(blogId: $blogId, blogTitle: $blogTitle, blogContent: $blogContent, blogImageUrl: $blogImageUrl, blogTopics: $blogTopics, updatedAt: $updatedAt, uploaderId: $uploaderId)';
  } */
}
