import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class FetchPostsUseCase {
  final PostRepository repository;

  FetchPostsUseCase(this.repository);

  Stream<List<Post>> call() {
    return repository.fetchPostsStream();
  }
}
