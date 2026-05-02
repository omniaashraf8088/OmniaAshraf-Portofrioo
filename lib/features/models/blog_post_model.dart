class BlogPostModel {
  final int id;
  final String title;
  final String titleAr;
  final String summary;
  final String summaryAr;
  final DateTime date;
  final String readTime;
  final String readTimeAr;
  final String url;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.summary,
    required this.summaryAr,
    required this.date,
    required this.readTime,
    required this.readTimeAr,
    required this.url,
  });
}
