import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tiktok_clone/failure.dart';
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

  CollectionReference get _post => _firestore.collection('videos');

  void likingPost(PostVideo post, String uid) async {
    if (post.likes.contains(uid)) {
      _post.doc(post.id).update(
        {
          'likes': FieldValue.arrayRemove([uid])
        },
      );
    } else {
      _post.doc(post.id).update(
        {
          'likes': FieldValue.arrayUnion([uid])
        },
      );
    }
  }
}
