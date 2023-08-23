import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/models/comments.dart';
import 'package:tiktok_clone/models/postVideo.dart';
import 'package:tiktok_clone/provider/firebaseProvider.dart';
import 'package:tiktok_clone/repository/video_repository.dart';
import 'package:tiktok_clone/utl.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

final videoControllerProvider = StateNotifierProvider<VideoController, bool>(
  (ref) => VideoController(
    videoRepository: ref.read(videoRepositoryProvider),
    ref: ref,
    firebaseStorage: ref.read(storageProvider),
  ),
); //Provider for fetching comment
final commentProvider = StreamProvider.family((ref, String postId) =>
    ref.watch(videoControllerProvider.notifier).fetchComments(postId));
//Provider for getting posts
final postedVideoProvider = StreamProvider(
    (ref) => ref.watch(videoControllerProvider.notifier).getPostedVideos());

class VideoController extends StateNotifier<bool> {
  final VideoRepository _videoRepository;
  final Ref _ref;
  final FirebaseStorage _firebaseStorage;
  VideoController({
    required VideoRepository videoRepository,
    required Ref ref,
    required FirebaseStorage firebaseStorage,
  })  : _videoRepository = videoRepository,
        _firebaseStorage = firebaseStorage,
        _ref = ref,
        super(false);

  Future<String> uploadVideoToStorage(String id, String path) async {
    Reference ref = _firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(
      await _compressFile(path),
    );
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> uploadImageToSource(String id, String videoPath) async {
    Reference ref = _firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void uploadVideo(
    String songName,
    String caption,
    String videoPath,
    BuildContext context,
  ) async {
    state = true;
    final user = _ref.read(userProvider)!;
    String id = const Uuid().v1();
    String videoUrl = await uploadVideoToStorage(id, videoPath);
    final thumbnail = await uploadImageToSource(id, videoPath);
    PostVideo video = PostVideo(
      userName: user.name,
      id: id,
      uid: user.uid,
      likes: [],
      songName: songName,
      caption: caption,
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      profilePhoto: user.profilePic,
      commentCount: 0,
      shareCount: 0,
    );
    final res = await _videoRepository.uploadVideo(video);
    state = false;
    res.fold(
      (l) => showSnackBar(
        context,
        l.toString(),
      ),
      (r) => Navigator.of(context).pop(),
    );
  }

  _compressFile(String path) async {
    final compressedVideo = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Stream<List<PostVideo>> getPostedVideos() {
    return _videoRepository.getPosts();
  }

  void likingPost(PostVideo post) async {
    final user = _ref.read(userProvider)!;
    _videoRepository.likingPost(post, user.uid);
  }

  void addComment(
      {required String postId,
      required String text,
      required BuildContext context}) async {
    final commentId = const Uuid().v1();
    final user = _ref.read(userProvider)!;
    Comments comment = Comments(
      username: user.name,
      id: commentId,
      uid: user.uid,
      profilePic: user.profilePic,
      comment: text,
      createdAt: DateTime.now(),
      likes: [],
    );
    final res = await _videoRepository.addComment(comment, postId);
    res.fold((l) => showSnackBar(context, l.toString()), (r) => null);
  }

  Stream<List<Comments>> fetchComments(String postId) {
    return _videoRepository.fetchComments(postId);
  }
}
