class ContactMessage {
  final String name;
  final String email;
  final String message;
  final DateTime timestamp;
  final String contactMethod; // 'whatsapp' or 'email'

  ContactMessage({
    required this.name,
    required this.email,
    required this.message,
    required this.timestamp,
    required this.contactMethod,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
        'contactMethod': contactMethod,
      };

  factory ContactMessage.fromJson(Map<String, dynamic> json) => ContactMessage(
        name: json['name'] as String,
        email: json['email'] as String,
        message: json['message'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        contactMethod: json['contactMethod'] as String,
      );
}
