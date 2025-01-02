import 'package:flutter_twitter_clone/data/data_sources/post_data_source.dart';
import 'package:flutter_twitter_clone/data/dtos/post_dto.dart';

import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource dataSource;

  PostRepositoryImpl(this.dataSource);

  @override
  Stream<List<Post>> fetchPostsStream() {
    return dataSource.fetchPostsFromFirestore().map(
          (snapshot) => snapshot.map((data) {
            return PostDTO.fromMap(data, data['id']).toEntity();
          }).toList(),
        );
  }

  @override
  Future<void> createPost(Post post) async {
    final postData = PostDTO.fromEntity(post).toMap();
    await dataSource.createPostInFirestore(postData);
  }

  @override
  Future<void> likePost(String postId, bool isLiked) async {
    await dataSource.likePostInFirestore(postId, isLiked);
  }
}
