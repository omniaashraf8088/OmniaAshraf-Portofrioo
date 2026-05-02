import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/notification_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../l10n/app_en.dart';
import '../../../l10n/app_ar.dart';
import '../../models/contact_message_model.dart';

class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState extends State<AdminNotificationsScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isAuthenticated = false;
  static const String _adminPassword = '2004'; // Change this to your password

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticate() {
    if (_passwordController.text == _adminPassword) {
      setState(() {
        _isAuthenticated = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('كلمة المرور غير صحيحة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isArabic = languageProvider.currentLanguage == 'ar';

    if (!_isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text(isArabic
              ? AppLocalizationsAr.adminPanel
              : AppLocalizationsEn.adminPanel),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  isArabic
                      ? AppLocalizationsAr.enterPassword
                      : AppLocalizationsEn.enterPassword,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: isArabic
                        ? AppLocalizationsAr.password
                        : AppLocalizationsEn.password,
                    prefixIcon: const Icon(Icons.vpn_key),
                    border: const OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _authenticate(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(isArabic
                      ? AppLocalizationsAr.login
                      : AppLocalizationsEn.login),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic
            ? AppLocalizationsAr.receivedMessages
            : AppLocalizationsEn.receivedMessages),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, _) {
              return IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: notificationProvider.messages.isEmpty
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(isArabic
                                ? AppLocalizationsAr.clearAll
                                : AppLocalizationsEn.clearAll),
                            content: Text(
                              isArabic
                                  ? 'هل تريد مسح جميع الرسائل؟'
                                  : 'Delete all messages?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(isArabic
                                    ? AppLocalizationsAr.cancel
                                    : AppLocalizationsEn.cancel),
                              ),
                              TextButton(
                                onPressed: () {
                                  notificationProvider.clearMessages();
                                  Navigator.pop(context);
                                },
                                child: Text(isArabic
                                    ? AppLocalizationsAr.delete
                                    : AppLocalizationsEn.delete),
                              ),
                            ],
                          ),
                        );
                      },
                tooltip: isArabic
                    ? AppLocalizationsAr.clearAll
                    : AppLocalizationsEn.clearAll,
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, _) {
          if (notificationProvider.messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isArabic
                        ? AppLocalizationsAr.noMessages
                        : AppLocalizationsEn.noMessages,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notificationProvider.messages.length,
            itemBuilder: (context, index) {
              final message = notificationProvider.messages[index];
              return _MessageCard(
                message: message,
                index: index,
                isArabic: isArabic,
              );
            },
          );
        },
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final ContactMessage message;
  final int index;
  final bool isArabic;

  const _MessageCard({
    required this.message,
    required this.index,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    final dateFormat = DateFormat('dd/MM/yyyy - hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: message.contactMethod == 'whatsapp'
              ? const Color(0xFF25D366)
              : Theme.of(context).colorScheme.primary,
          child: Icon(
            message.contactMethod == 'whatsapp' ? Icons.chat : Icons.email,
            color: Colors.white,
          ),
        ),
        title: Text(
          message.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          dateFormat.format(message.timestamp),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(isArabic
                    ? AppLocalizationsAr.deleteMessage
                    : AppLocalizationsEn.deleteMessage),
                content: Text(
                  isArabic
                      ? 'هل تريد حذف هذه الرسالة؟'
                      : 'Delete this message?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(isArabic
                        ? AppLocalizationsAr.cancel
                        : AppLocalizationsEn.cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      notificationProvider.removeMessage(index);
                      Navigator.pop(context);
                    },
                    child: Text(isArabic
                        ? AppLocalizationsAr.delete
                        : AppLocalizationsEn.delete),
                  ),
                ],
              ),
            );
          },
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.email,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                Text(
                  isArabic
                      ? AppLocalizationsAr.messageLabel
                      : AppLocalizationsEn.messageLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(message.message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
