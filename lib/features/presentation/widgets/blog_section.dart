import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';
    final blogPosts = PortfolioData.blogPosts;

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
                    ? AppLocalizationsAr.blogTitle
                    : AppLocalizationsEn.blogTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? AppLocalizationsAr.blogSubtitle
                    : AppLocalizationsEn.blogSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = Responsive.isMobile(context) ? 1 : 2;
                  const spacing = 16.0;
                  final cardWidth = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: blogPosts.map((post) {
                      return SizedBox(
                        width: cardWidth,
                        child: _buildBlogCard(context, post, isArabic),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, dynamic post, bool isArabic) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      child: InkWell(
        onTap: () => _launchUrl(post.url),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isArabic ? post.titleAr : post.title,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Text(
                isArabic ? post.summaryAr : post.summary,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.calendar,
                    size: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    dateFormat.format(post.date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  FaIcon(
                    FontAwesomeIcons.clock,
                    size: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isArabic ? post.readTimeAr : post.readTime,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    isArabic
                        ? AppLocalizationsAr.readMore
                        : AppLocalizationsEn.readMore,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
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
