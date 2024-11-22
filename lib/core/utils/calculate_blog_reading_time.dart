int calculateBlogReadingTime(int wordCount) {
  final int time = (wordCount / 225).ceil();

  return time;
}
