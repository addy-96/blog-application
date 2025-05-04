sealed class DeleteBlogState {}

final class DeleteBlogInitialState extends DeleteBlogState {}

final class DeleteBlogLoadingState extends DeleteBlogState {}

final class DeleteBlogSuccessState extends DeleteBlogState {
  final bool deleteStatus;
  DeleteBlogSuccessState({
    required this.deleteStatus,
  });
}

final class DeleteBlogFailureState extends DeleteBlogState {
  final String errorMessage;
  DeleteBlogFailureState({required this.errorMessage});
}
