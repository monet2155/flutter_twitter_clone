import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter_clone/data/data_sources/post_data_source.dart';
import 'package:flutter_twitter_clone/data/repositories/post_repository_impl.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/fetch_posts_usecase.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/like_post_usecase.dart';

class PostViewModel extends StateNotifier<List<Post>> {
  final FetchPostsUseCase fetchPostsUseCase;
  final CreatePostUseCase createPostUseCase;
  final LikePostUseCase likePostUseCase;

  PostViewModel({
    required this.fetchPostsUseCase,
    required this.createPostUseCase,
    required this.likePostUseCase,
  }) : super([]) {
    _initializePosts();
  }

  // Initialize posts with real-time updates from Firestore
  void _initializePosts() {
    fetchPostsUseCase().listen((posts) {
      state = posts;
    });
  }

  // Create a new post
  Future<void> createPost(String content, [String? imageUrl]) async {
    final newPost = Post(
      id: '', // Firestore will assign an ID
      content: content,
      imageUrl: imageUrl,
      timestamp: DateTime.now(),
    );
    await createPostUseCase(newPost);
  }

  // Like or unlike a post
  Future<void> likePost(String postId, bool isLiked) async {
    await likePostUseCase(postId, isLiked);
  }
}

final postViewModelProvider =
    StateNotifierProvider<PostViewModel, List<Post>>((ref) {
  final firestore = FirebaseFirestore.instance;
  final dataSource = PostDataSource(firestore);
  final repository = PostRepositoryImpl(dataSource);

  return PostViewModel(
    fetchPostsUseCase: FetchPostsUseCase(repository),
    createPostUseCase: CreatePostUseCase(repository),
    likePostUseCase: LikePostUseCase(repository),
  );
});
