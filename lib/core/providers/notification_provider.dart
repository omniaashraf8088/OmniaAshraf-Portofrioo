import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/models/contact_message_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<ContactMessage> _messages = [];
  static const String _storageKey = 'contact_messages';

  List<ContactMessage> get messages => _messages;
  int get messageCount => _messages.length;
  bool get hasUnreadMessages => _messages.isNotEmpty;

  NotificationProvider() {
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString(_storageKey);
    if (messagesJson != null) {
      final List<dynamic> decoded = jsonDecode(messagesJson);
      _messages = decoded.map((json) => ContactMessage.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded =
        jsonEncode(_messages.map((m) => m.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> addMessage(ContactMessage message) async {
    _messages.insert(0, message); // Add to beginning
    await _saveMessages();
    notifyListeners();
  }

  Future<void> clearMessages() async {
    _messages.clear();
    await _saveMessages();
    notifyListeners();
  }

  Future<void> removeMessage(int index) async {
    _messages.removeAt(index);
    await _saveMessages();
    notifyListeners();
  }
}
