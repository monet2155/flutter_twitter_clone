import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_twitter_clone/presentation/pages/create_post_page.dart';
import 'package:flutter_twitter_clone/presentation/pages/post_detail_page.dart';
import 'package:flutter_twitter_clone/presentation/viewmodels/post_view_model.dart';

class FeedPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: posts.isEmpty
          ? Center(
              child: Text('No posts yet. Create one!'),
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(post.content),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Posted at: ${post.timestamp}'),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {
                                ref
                                    .read(postViewModelProvider.notifier)
                                    .likePost(post.id, true);
                              },
                            ),
                            Text('${post.likesCount} likes'),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to PostDetailPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailPage(postId: post.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
