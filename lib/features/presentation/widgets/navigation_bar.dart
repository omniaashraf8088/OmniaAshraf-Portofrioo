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
          GestureDetector(
            onTap: () => _showLogoDialog(context),
            child: Container(
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

  void _showLogoDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Logo',
      barrierColor: Colors.black.withValues(alpha: 0.0),
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const _LogoDialogContent();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
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

// ── Animated Logo Dialog ─────────────────────────────────────────
class _LogoDialogContent extends StatefulWidget {
  const _LogoDialogContent();

  @override
  State<_LogoDialogContent> createState() => _LogoDialogContentState();
}

class _LogoDialogContentState extends State<_LogoDialogContent>
    with TickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _bgCtrl;

  late final Animation<double> _scaleAnim;
  late final Animation<double> _glowAnim;
  late final Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();

    // Background fade
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bgAnim = CurvedAnimation(parent: _bgCtrl, curve: Curves.easeOut);

    // Star pop scale — elastic overshoot
    _scaleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _scaleAnim = CurvedAnimation(
      parent: _scaleCtrl,
      curve: Curves.elasticOut,
    );

    // Continuous neon glow pulse
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut),
    );

    // Kick off animations in sequence
    _bgCtrl.forward();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) _scaleCtrl.forward();
    });
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    _glowCtrl.dispose();
    _bgCtrl.dispose();
    super.dispose();
  }

  void _close() {
    _scaleCtrl.reverse();
    _bgCtrl.reverse();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _close,
      child: AnimatedBuilder(
        animation: Listenable.merge([_bgAnim, _scaleAnim, _glowAnim]),
        builder: (context, child) {
          return Container(
            color: Colors.black.withValues(alpha: 0.82 * _bgAnim.value),
            child: Center(
              child: ScaleTransition(
                scale: _scaleAnim,
                child: GestureDetector(
                  onTap: () {}, // prevent closing when tapping logo
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ── Outer glow rays (star burst) ──
                      Container(
                        width: 560 + (20 * _glowAnim.value),
                        height: 560 + (20 * _glowAnim.value),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00E5FF)
                                  .withValues(alpha: 0.55 * _glowAnim.value),
                              blurRadius: 80,
                              spreadRadius: 20,
                            ),
                            BoxShadow(
                              color: const Color(0xFF1565C0)
                                  .withValues(alpha: 0.4 * _glowAnim.value),
                              blurRadius: 120,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),

                      // ── Logo image ──
                      Container(
                        width: 520,
                        height: 520,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.lerp(
                              const Color(0xFF00E5FF),
                              const Color(0xFF80DFFF),
                              _glowAnim.value,
                            )!,
                            width: 3.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo.jpg',
                            width: 520,
                            height: 520,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF0D1B2A),
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFF00E5FF),
                                  size: 100,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // ── Close button ──
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _close,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF00E5FF)
                                    .withValues(alpha: 0.8),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00E5FF)
                                      .withValues(alpha: 0.4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
