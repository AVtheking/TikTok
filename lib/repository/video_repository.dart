import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tiktok_clone/failure.dart';
import 'package:tiktok_clone/models/comments.dart';
import 'package:tiktok_clone/models/postVideo.dart';
import 'package:tiktok_clone/provider/firebaseProvider.dart';
import 'package:tiktok_clone/typedef.dart';

final videoRepositoryProvider = Provider(
  (ref) => VideoRepository(
    fireStore: ref.read(firestoreProvider),
  ),
);

class VideoRepository {
  final FirebaseFirestore _firestore;
  VideoRepository({required FirebaseFirestore fireStore})
      : _firestore = fireStore;

  CollectionReference get _post => _firestore.collection('videos');

  FutureVoid uploadVideo(PostVideo video) async {
    try {
      return right(
          _firestore.collection('videos').doc(video.id).set(video.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<PostVideo>> getPosts() {
    return _firestore.collection('videos').snapshots().map((event) {
      List<PostVideo> videos = [];
      for (var video in event.docs) {
        videos.add(
          PostVideo.fromMap(video.data()),
        );
      }
      return videos;
    });
  }

  void likingPost(PostVideo post, String uid) async {
    if (post.likes.contains(uid)) {
      _firestore.collection('videos').doc(post.id).update(
        {
          'likes': FieldValue.arrayRemove([uid])
        },
      );
    } else {
      _firestore.collection('videos').doc(post.id).update(
        {
          'likes': FieldValue.arrayUnion([uid])
        },
      );
    }
  }

  // CollectionReference get _comment => _firestore.collection('comments');
  FutureVoid addComment(Comments comment, String postId) async {
    try {
      await _firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .doc(comment.id)
          .set(comment.toMap());
      return right(
          _post.doc(postId).update({'commentCount': FieldValue.increment(1)}));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  Stream<List<Comments>> fetchComments(String postId) {
    return _post
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) {
      List<Comments> comments = [];
      for (var comment in event.docs) {
        comments.add(Comments.fromMap(comment.data()));
      }
      return comments;
    });
  }
}
