import 'package:flutter/material.dart';
import 'package:portfolio_flutter/core/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/providers/notification_provider.dart';
import '../../models/contact_message_model.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  String? _statusMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendViaWhatsApp(bool isArabic) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _statusMessage = null;
      });

      // Prepare WhatsApp message
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      final whatsappMessage = Uri.encodeComponent('مرحباً! 👋\n\n'
          'الاسم: $name\n'
          'البريد الإلكتروني: $email\n\n'
          'الرسالة:\n$message');

      final whatsappUrl =
          'https://wa.me/message/KBKG2WZ5ZQNRO1?text=$whatsappMessage';

      // Open WhatsApp
      await _launchUrl(whatsappUrl);

      setState(() {
        _isSubmitting = false;
        _statusMessage = isArabic
            ? AppLocalizationsAr.openingWhatsApp
            : AppLocalizationsEn.openingWhatsApp;
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });

      if (mounted) {
        final contactMessage = ContactMessage(
          name: name,
          email: email,
          message: message,
          timestamp: DateTime.now(),
          contactMethod: 'whatsapp',
        );
        await context.read<NotificationProvider>().addMessage(contactMessage);
      }

      // Clear success message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _statusMessage = null;
          });
        }
      });
    }
  }

  Future<void> _sendViaEmail(bool isArabic) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _statusMessage = null;
      });

      // Prepare email
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      final subject = Uri.encodeComponent('Portfolio Contact from $name');
      final body = Uri.encodeComponent('Name: $name\n'
          'Email: $email\n\n'
          'Message:\n$message');

      final emailUrl =
          'mailto:omniaashraf8088@gmail.com?subject=$subject&body=$body';

      // Open email client
      await _launchUrl(emailUrl);

      setState(() {
        _isSubmitting = false;
        _statusMessage = isArabic
            ? AppLocalizationsAr.openingEmail
            : AppLocalizationsEn.openingEmail;
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });

      if (mounted) {
        final contactMessage = ContactMessage(
          name: name,
          email: email,
          message: message,
          timestamp: DateTime.now(),
          contactMethod: 'email',
        );
        await context.read<NotificationProvider>().addMessage(contactMessage);
      }

      // Clear success message after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _statusMessage = null;
          });
        }
      });
    }
  }

  Future<void> _launchUrl(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      final isMailTo = urlString.startsWith('mailto:');
      final mode = isMailTo
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication;

      if (!await launchUrl(url, mode: mode)) {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Exception while launching $urlString: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';

    return Container(
      padding: Responsive.pagePadding(context).copyWith(top: 0),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Text(
                isArabic
                    ? AppLocalizationsAr.contactTitle
                    : AppLocalizationsEn.contactTitle,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                isArabic
                    ? AppLocalizationsAr.contactSubtitle
                    : AppLocalizationsEn.contactSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: isArabic
                                ? AppLocalizationsAr.name
                                : AppLocalizationsEn.name,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return isArabic
                                  ? AppLocalizationsAr.nameRequired
                                  : AppLocalizationsEn.nameRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: isArabic
                                ? AppLocalizationsAr.email
                                : AppLocalizationsEn.email,
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return isArabic
                                  ? AppLocalizationsAr.emailRequired
                                  : AppLocalizationsEn.emailRequired;
                            }
                            if (!value.contains('@')) {
                              return isArabic
                                  ? AppLocalizationsAr.emailInvalid
                                  : AppLocalizationsEn.emailInvalid;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            labelText: isArabic
                                ? AppLocalizationsAr.message
                                : AppLocalizationsEn.message,
                            prefixIcon: const Icon(Icons.message),
                          ),
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return isArabic
                                  ? AppLocalizationsAr.messageRequired
                                  : AppLocalizationsEn.messageRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_statusMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Colors.green),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _statusMessage!,
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),

                        // Contact buttons row
                        Row(
                          children: [
                            // WhatsApp Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isSubmitting
                                    ? null
                                    : () => _sendViaWhatsApp(isArabic),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF25D366), // WhatsApp green
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Image.asset(
                                        'assets/icons/whatsapp-icon-.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      isArabic
                                          ? AppLocalizationsAr.whatsappMethod
                                          : AppLocalizationsEn.whatsappMethod,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Email Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _isSubmitting
                                    ? null
                                    : () => _sendViaEmail(isArabic),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Image.asset(
                                        'assets/icons/email.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      isArabic
                                          ? AppLocalizationsAr.emailMethod
                                          : AppLocalizationsEn.emailMethod,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
