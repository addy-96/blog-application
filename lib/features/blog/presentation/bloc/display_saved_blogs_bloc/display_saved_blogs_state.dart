part of 'display_saved_blogs_bloc.dart';

class DisplaySavedBlogsState {}

class DisplaySavedBlogsInitialState extends DisplaySavedBlogsState {}

class DisplaySavedBlogsLoadingState extends DisplaySavedBlogsState {}

class DisplaySavedBlogsSuccessState extends DisplaySavedBlogsState {
  final List<Blog> blogList;
  DisplaySavedBlogsSuccessState({required this.blogList,});
}

class DispalySavedBlogsFailureState extends DisplaySavedBlogsState {
  final String errorMessage;
  DispalySavedBlogsFailureState({required this.errorMessage});
}
