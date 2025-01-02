import 'package:flutter_twitter_clone/domain/entities/post.dart';

class PostDTO {
  final String id;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final int likesCount;
  final int commentsCount;

  PostDTO({
    required this.id,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    this.likesCount = 0,
    this.commentsCount = 0,
  });

  // Factory constructor to create a PostDTO from a map.
  factory PostDTO.fromMap(Map<String, dynamic> map, String documentId) {
    return PostDTO(
      id: documentId,
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      timestamp: DateTime.parse(map['timestamp']),
      likesCount: map['likesCount'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
    );
  }

  // Converts a PostDTO to a Post entity.
  Post toEntity() {
    return Post(
      id: id,
      content: content,
      imageUrl: imageUrl,
      timestamp: timestamp,
      likesCount: likesCount,
      commentsCount: commentsCount,
    );
  }

  // Converts a Post entity to a PostDTO.
  factory PostDTO.fromEntity(Post post) {
    return PostDTO(
      id: post.id,
      content: post.content,
      imageUrl: post.imageUrl,
      timestamp: post.timestamp,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
    );
  }

  // Converts a PostDTO to a map for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }
}
