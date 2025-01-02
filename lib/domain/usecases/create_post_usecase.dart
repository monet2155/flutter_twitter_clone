import 'package:flutter_twitter_clone/domain/entities/post.dart';
import 'package:flutter_twitter_clone/domain/repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<void> call(Post post) async {
    return repository.createPost(post);
  }
}
