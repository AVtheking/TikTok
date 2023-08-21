import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tiktok_clone/failure.dart';
import 'package:tiktok_clone/models/postVideo.dart';

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
}
