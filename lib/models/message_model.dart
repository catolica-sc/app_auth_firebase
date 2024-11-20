class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  MessageModel({required this.senderId, required this.receiverId, required this.message, required this.timestamp});
}