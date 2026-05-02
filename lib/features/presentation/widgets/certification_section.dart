import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../data/portfolio_data.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';
    final certificates = PortfolioData.certificates;

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
                    ? AppLocalizationsAr.certificatesTitle
                    : AppLocalizationsEn.certificatesTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                isArabic
                    ? AppLocalizationsAr.certificatesSubtitle
                    : AppLocalizationsEn.certificatesSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 46),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context)
                      ? 1
                      : (Responsive.isTablet(context) ? 2 : 4),
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: certificates.length,
                itemBuilder: (context, index) {
                  final cert = certificates[index];
                  return _buildCertificateCard(context, cert, isArabic, index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // List of certificate images for variety
  static const List<String> _certificateImages = [
    'assets/icons/hd-gold-black-certificate-logo.png',
    'assets/icons/gold-certificate-icon.jpg',
    'assets/icons/hd-gold-black-certificate-logo.png',
    'assets/icons/gold-certificate-icon.jpg',
    'assets/icons/hd-gold-black-certificate-logo.png',
    'assets/icons/gold-certificate-icon.jpg',
  ];

  Widget _buildCertificateCard(
      BuildContext context, dynamic cert, bool isArabic, int index) {
    final dateFormat = DateFormat('MMMM yyyy');
    // Rotate through images based on index
    final imageIndex = index % _certificateImages.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Certificate image in center
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  _certificateImages[imageIndex],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.amber.shade100,
                      child: const Icon(Icons.workspace_premium,
                          color: Colors.amber, size: 32),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Certificate title
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isArabic ? cert.titleAr : cert.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  '${isArabic ? AppLocalizationsAr.issuedBy : AppLocalizationsEn.issuedBy}: ${isArabic ? cert.issuerAr : cert.issuer}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      dateFormat.format(cert.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            if (cert.credentialUrl != null) ...[
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _launchUrl(cert.credentialUrl!),
                icon: const Icon(Icons.open_in_new, size: 14),
                label: Text(
                  isArabic
                      ? AppLocalizationsAr.viewCredential
                      : AppLocalizationsEn.viewCredential,
                  style: const TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Colors.amber.shade300,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ],
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
