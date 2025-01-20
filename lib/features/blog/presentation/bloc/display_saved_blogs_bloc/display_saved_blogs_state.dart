part of 'display_saved_blogs_bloc.dart';

sealed class DisplaySavedBlogsState {}

final class DisplaySavedBlogsInitialState extends DisplaySavedBlogsState {}

final class DisplaySavedBlogsLoadingState extends DisplaySavedBlogsState {}

final class DisplaySavedBlogsSuccessState extends DisplaySavedBlogsState {
  final List<Blog> blogList;
  DisplaySavedBlogsSuccessState({required this.blogList,});
}

final class DispalySavedBlogsFailureState extends DisplaySavedBlogsState {
  final String errorMessage;
  DispalySavedBlogsFailureState({required this.errorMessage});
}
