class ProjectModel {
  final int id;
  final String title;
  final String titleAr;
  final String description;
  final String descriptionAr;
  final String imageUrl;
  final List<String> techStack;
  final String? githubUrl;
  final String? demoUrl;
  final bool featured;

  ProjectModel({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.descriptionAr,
    required this.imageUrl,
    required this.techStack,
    this.githubUrl,
    this.demoUrl,
    this.featured = false,
  });
}
