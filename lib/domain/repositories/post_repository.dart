import 'package:flutter_twitter_clone/domain/entities/post.dart';

abstract class PostRepository {
  Stream<List<Post>> fetchPostsStream();

  Future<void> createPost(Post post);

  Future<void> likePost(String postId, bool isLiked);
}
