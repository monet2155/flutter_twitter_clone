class Post {
  final String id;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final int likesCount;
  final int commentsCount;

  Post({
    required this.id,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    this.likesCount = 0,
    this.commentsCount = 0,
  });
}
