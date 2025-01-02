import 'package:cloud_firestore/cloud_firestore.dart';

class PostDataSource {
  final FirebaseFirestore firestore;

  PostDataSource(this.firestore);

  // Fetch posts as a stream from Firestore
  Stream<List<Map<String, dynamic>>> fetchPostsFromFirestore() {
    return firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          ...data,
          'id': doc.id, // Include document ID
        };
      }).toList();
    });
  }

  // Create a new post in Firestore
  Future<void> createPostInFirestore(Map<String, dynamic> postData) async {
    await firestore.collection('posts').add(postData);
  }

  // Update likes for a post in Firestore
  Future<void> likePostInFirestore(String postId, bool isLiked) async {
    await firestore.collection('posts').doc(postId).update({
      'likesCount': FieldValue.increment(isLiked ? 1 : -1),
    });
  }
}
