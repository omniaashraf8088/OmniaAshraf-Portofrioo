import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';
    final projects = PortfolioData.projects;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: Responsive.pagePadding(context),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Column(
            children: [
              Text(
                isArabic
                    ? AppLocalizationsAr.projectsTitle
                    : AppLocalizationsEn.projectsTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isArabic
                    ? AppLocalizationsAr.projectsSubtitle
                    : AppLocalizationsEn.projectsSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.gridColumns(context),
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return _buildProjectCard(context, project, isArabic);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
      BuildContext context, dynamic project, bool isArabic) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              project.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? project.titleAr : project.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  isArabic ? project.descriptionAr : project.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: project.techStack
                      .take(3)
                      .map<Widget>((tech) => Chip(
                            label: Text(
                              tech,
                              style: const TextStyle(fontSize: 10),
                            ),
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (project.githubUrl != null)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.githubUrl!),
                          icon: const FaIcon(FontAwesomeIcons.github, size: 14),
                          label: Text(
                            isArabic
                                ? AppLocalizationsAr.viewCode
                                : AppLocalizationsEn.viewCode,
                            style: const TextStyle(fontSize: 11),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 8),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                    if (project.githubUrl != null && project.demoUrl != null)
                      const SizedBox(width: 12),
                    if (project.demoUrl != null)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.demoUrl!),
                          icon: const Icon(Icons.launch, size: 14),
                          label: Text(
                            isArabic
                                ? AppLocalizationsAr.viewDemo
                                : AppLocalizationsEn.viewDemo,
                            style: const TextStyle(fontSize: 11),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }
}
