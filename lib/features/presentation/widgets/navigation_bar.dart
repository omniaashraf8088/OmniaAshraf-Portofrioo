import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/providers/notification_provider.dart';
import '../screens/admin_notifications_screen.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../../core/utils/responsive.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onNavigate;

  const CustomNavigationBar({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';

    final navItems = [
      isArabic ? AppLocalizationsAr.about : AppLocalizationsEn.about,
      isArabic ? AppLocalizationsAr.skills : AppLocalizationsEn.skills,
      isArabic ? AppLocalizationsAr.projects : AppLocalizationsEn.projects,
      isArabic
          ? AppLocalizationsAr.certificates
          : AppLocalizationsEn.certificates,
      isArabic ? AppLocalizationsAr.blog : AppLocalizationsEn.blog,
      isArabic ? AppLocalizationsAr.contact : AppLocalizationsEn.contact,
    ];

    return SliverAppBar(
      pinned: true, // Keep the navigation bar fixed on scroll
      floating: true,
      snap: true,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
      elevation: 2,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.primary,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Portfolio',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const Spacer(),
          if (Responsive.isDesktop(context))
            ...List.generate(
              navItems.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () => onNavigate(index),
                  child: Text(navItems[index]),
                ),
              ),
            ),
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeProvider.toggleTheme,
          ),
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: Color(0xFFFFD700), // Fixed yellow
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AdminNotificationsScreen(),
                        ),
                      );
                    },
                  ),
                  if (notificationProvider.hasUnreadMessages)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF0000), // Fixed red
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '${notificationProvider.messageCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          TextButton.icon(
            onPressed: languageProvider.toggleLanguage,
            icon: const Icon(Icons.language),
            label: Text(isArabic
                ? AppLocalizationsAr.english
                : AppLocalizationsEn.arabic),
          ),
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context, navItems, onNavigate),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(
    BuildContext context,
    List<String> navItems,
    Function(int) onNavigate,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: navItems.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(navItems[index]),
          onTap: () {
            Navigator.pop(context);
            onNavigate(index);
          },
        ),
      ),
    );
  }
}
