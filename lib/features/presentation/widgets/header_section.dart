import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height - 100,
      ),
      padding: Responsive.pagePadding(context),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Responsive.isMobile(context)
              ? _buildMobileLayout(context, isArabic)
              : _buildDesktopLayout(context, isArabic),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, bool isArabic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context),
        const SizedBox(height: 20),
        _buildProfileInfo(context, isArabic),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isArabic) {
    return Row(
      children: [
        Expanded(child: _buildProfileImage(context)),
        const SizedBox(width: 48),
        Expanded(child: _buildProfileInfo(context, isArabic)),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Hero(
      tag: 'profile',
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            PortfolioData.profileImagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                child: Icon(
                  Icons.person,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? PortfolioData.nameAr : PortfolioData.name,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 4),
        Text(
          isArabic ? PortfolioData.titleAr : PortfolioData.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 10),
        // Availability Badge — trust signal for recruiters
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                isArabic
                    ? AppLocalizationsAr.availableForWork
                    : AppLocalizationsEn.availableForWork,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isArabic ? PortfolioData.bioAr : PortfolioData.bio,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        _buildSocialLinks(context),
        const SizedBox(height: 20),
        _buildActionButtons(context, isArabic),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildSocialImageIcon(
            context, 'assets/icons/github.png', PortfolioData.githubUrl),
        _buildSocialImageIcon(
            context, 'assets/icons/linked in.png', PortfolioData.linkedinUrl),
        _buildSocialImageIcon(
            context, 'assets/icons/X-icon.png', PortfolioData.twitterUrl),
        _buildSocialImageIcon(context, 'assets/icons/facbook_icon.webp',
            PortfolioData.facebookUrl),
        _buildSocialImageIcon(context, 'assets/icons/whatsapp-icon-.jpg',
            PortfolioData.whatsappUrl),
        _buildSocialImageIcon(
            context, 'assets/icons/instgram.jpg', PortfolioData.instagramUrl),
        _buildSocialImageIcon(
            context, 'assets/icons/upwork_icon.jpg', PortfolioData.upworkUrl),
        _buildSocialImageIcon(
            context, 'assets/icons/medium_icon.jpg', PortfolioData.mediumUrl),
      ],
    );
  }

  Widget _buildSocialImageIcon(
      BuildContext context, String imagePath, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: ClipRect(
          child: Image.asset(
            imagePath,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.link,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isArabic) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        // Primary CTA — See My Work
        ElevatedButton.icon(
          onPressed: () => _launchUrl('https://laffa-dashboard.vercel.app/'),
          icon: const Icon(Icons.launch),
          label: Text(
            isArabic
                ? AppLocalizationsAr.viewWork
                : AppLocalizationsEn.viewWork,
          ),
        ),
        // Secondary CTA — Download CV
        OutlinedButton.icon(
          onPressed: () => _launchUrl(PortfolioData.cvUrl),
          icon: const Icon(Icons.download),
          label: Text(
            isArabic
                ? AppLocalizationsAr.downloadCV
                : AppLocalizationsEn.downloadCV,
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }
}
