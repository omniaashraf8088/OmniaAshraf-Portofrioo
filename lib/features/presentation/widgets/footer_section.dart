import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';
    final currentYear = DateTime.now().year;

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            '© $currentYear ${isArabic ? PortfolioData.nameAr : PortfolioData.name}. ${isArabic ? AppLocalizationsAr.rights : AppLocalizationsEn.rights}.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isArabic
                ? AppLocalizationsAr.builtWith
                : AppLocalizationsEn.builtWith,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
