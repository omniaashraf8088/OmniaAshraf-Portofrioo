import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';

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
                    ? AppLocalizationsAr.aboutTitle
                    : AppLocalizationsEn.aboutTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                isArabic
                    ? AppLocalizationsAr.aboutSubtitle
                    : AppLocalizationsEn.aboutSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        isArabic ? PortfolioData.bioAr : PortfolioData.bio,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 24,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildContactInfo(
                            context,
                            FontAwesomeIcons.locationDot,
                            isArabic
                                ? PortfolioData.locationAr
                                : PortfolioData.location,
                          ),
                          InkWell(
                            onTap: () async {
                              const email = 'omniaashraf8088@gmail.com';

                              // Fallback: Copy to clipboard
                              Clipboard.setData(
                                  const ClipboardData(text: email));

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isArabic
                                          ? 'تم نسخ البريد الإلكتروني للحافظة. يمكنك لصقه في بريدك لإرسال رسالة.'
                                          : 'Email copied to clipboard. You can paste it into your mail app.',
                                    ),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }

                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: email,
                              );
                              try {
                                await launchUrl(emailLaunchUri);
                              } catch (e) {
                                debugPrint('Could not launch email: $e');
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/email.jpg',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'omniaashraf8088@gmail.com',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontFamily:
                                            'sans-serif', // Fallback to a standard font for clear numbers
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, FaIconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(
          icon,
          size: 16,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
