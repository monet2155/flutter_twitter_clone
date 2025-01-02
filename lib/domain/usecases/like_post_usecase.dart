import 'package:flutter_twitter_clone/domain/repositories/post_repository.dart';

class LikePostUseCase {
  final PostRepository repository;

  LikePostUseCase(this.repository);

  Future<void> call(String postId, bool isLiked) async {
    return repository.likePost(postId, isLiked);
  }
}
