// features/messages/domain/entities/conversation_item.dart
class ConversationItem {
  final String id; // Unik ID har bir chat uchun
  final String correspondentName; // Suhbatdosh ismi
  final String? avatarAssetPath; // Suhbatdosh rasmining lokal yo'li
  final String lastMessage;
  final DateTime lastMessageTimestamp;
  late final bool isRead; // Oxirgi xabar o'qilganmi? (qizil nuqta uchun)
  final int unreadCount; // O'qilmagan xabarlar soni (agar kerak bo'lsa)

  ConversationItem({
    required this.id,
    required this.correspondentName,
    this.avatarAssetPath,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    this.isRead = true, // Default o'qilgan deb hisoblaymiz
    this.unreadCount = 0,
  });
}