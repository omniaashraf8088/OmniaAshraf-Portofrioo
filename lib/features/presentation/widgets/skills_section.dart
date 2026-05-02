import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';
    final skills = PortfolioData.skills;

    // Group skills by category
    final Map<String, List<dynamic>> groupedSkills = {};
    for (var skill in skills) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }

    return Container(
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
                    ? AppLocalizationsAr.skillsTitle
                    : AppLocalizationsEn.skillsTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                isArabic
                    ? AppLocalizationsAr.skillsSubtitle
                    : AppLocalizationsEn.skillsSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
                  childAspectRatio: Responsive.isMobile(context) ? 1.6 : 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: groupedSkills.length,
                itemBuilder: (context, index) {
                  final category = groupedSkills.keys.elementAt(index);
                  final categorySkills = groupedSkills[category]!;

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: categorySkills.length,
                                itemBuilder: (context, skillIndex) {
                                  final skill = categorySkills[skillIndex];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              skill.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              '${(skill.proficiency * 100).toInt()}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        TweenAnimationBuilder<double>(
                                          duration:
                                              const Duration(milliseconds: 1500),
                                          curve: Curves.easeInOut,
                                          tween: Tween<double>(
                                              begin: 0, end: skill.proficiency),
                                          builder: (context, value, _) =>
                                              LinearProgressIndicator(
                                            value: value,
                                            minHeight: 6,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
