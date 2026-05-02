import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/language_provider.dart';
import '../widgets/blog_section.dart';
import '../widgets/about_section.dart';
import '../widgets/animated_stars_background.dart';
import '../widgets/certification_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/header_section.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/project_section.dart';
import '../widgets/skills_section.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(7, (_) => GlobalKey());

  void _scrollToSection(int index) {
    // Add 1 to skip the Header section (index 0) to properly map navigation items to sections
    final key = _sectionKeys[index + 1];
    final context = key.currentContext;

    if (context != null && _scrollController.hasClients) {
      try {
        // Get the RenderBox to calculate exact position
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero, ancestor: null).dy;
        final currentScrollOffset = _scrollController.offset;
        final targetScrollOffset =
            currentScrollOffset + position - 80; // 80px offset for AppBar

        // Clamp target position to valid scroll range
        final clampedTarget = targetScrollOffset.clamp(
            0.0, _scrollController.position.maxScrollExtent);

        // Skip if already at or very close to target (within 5px tolerance)
        if ((currentScrollOffset - clampedTarget).abs() < 5) {
          return;
        }

        // Use ScrollController.animateTo for reliable, consistent scrolling
        // This automatically cancels any ongoing animation
        _scrollController.animateTo(
          clampedTarget,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      } catch (e) {
        // Silently handle any edge cases without breaking navigation
        debugPrint('Navigation error: $e');
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection:
          languageProvider.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: AnimatedStarsBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Navigation Bar
              CustomNavigationBar(onNavigate: _scrollToSection),

              // Sections
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeaderSection(key: _sectionKeys[0]),
                    AboutSection(key: _sectionKeys[1]),
                    SkillsSection(key: _sectionKeys[2]),
                    ProjectsSection(key: _sectionKeys[3]),
                    CertificatesSection(key: _sectionKeys[4]),
                    BlogSection(key: _sectionKeys[5]),
                    ContactSection(key: _sectionKeys[6]),
                    const FooterSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
