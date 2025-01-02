import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter_clone/presentation/viewmodels/post_view_model.dart';
import '../../domain/entities/post.dart';

class PostDetailPage extends ConsumerWidget {
  final String postId;

  PostDetailPage({required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(postViewModelProvider.select(
        (value) => value.firstWhere((element) => element.id == postId)));

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.content,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Posted at: ${post.timestamp.toString()}'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Likes: ${post.likesCount}'),
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    ref
                        .read(postViewModelProvider.notifier)
                        .likePost(post.id, true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
