import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio_flutter/core/providers/language_provider.dart';
import 'package:portfolio_flutter/core/providers/theme_provider.dart';
import 'package:portfolio_flutter/core/providers/notification_provider.dart';
import 'package:portfolio_flutter/features/presentation/screens/portfolio_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const OmnyaAshrafPortfolio(),
    ),
  );
}

class OmnyaAshrafPortfolio extends StatelessWidget {
  const OmnyaAshrafPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer2<ThemeProvider, LanguageProvider>(
          builder: (context, themeProvider, languageProvider, _) {
            return MaterialApp(
              title: 'Omnya Ashraf | Flutter Developer Portfolio',
              debugShowCheckedModeBanner: false,
              theme: themeProvider.lightTheme.copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(Colors.black87),
                  trackColor: WidgetStateProperty.all(Colors.grey.shade300),
                  thickness: WidgetStateProperty.all(8),
                  radius: const Radius.circular(10),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              darkTheme: themeProvider.darkTheme.copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(Colors.white70),
                  trackColor: WidgetStateProperty.all(Colors.grey.shade800),
                  thickness: WidgetStateProperty.all(8),
                  radius: const Radius.circular(10),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              themeMode: themeProvider.themeMode,
              locale: Locale(languageProvider.currentLanguage),
              home: const PortfolioHomePage(),
            );
          },
        );
      },
    );
  }
}
