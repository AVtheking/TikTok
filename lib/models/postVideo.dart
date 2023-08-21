// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class PostVideo {
  final String userName;
  final String id;
  final String uid;
  final List likes;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnail;
  final String profilePhoto;
  final int commentCount;
  final int shareCount;
  PostVideo({
    required this.userName,
    required this.id,
    required this.uid,
    required this.likes,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
    required this.commentCount,
    required this.shareCount,
  });

  PostVideo copyWith({
    String? userName,
    String? id,
    String? uid,
    List? likes,
    String? songName,
    String? caption,
    String? videoUrl,
    String? thumbnail,
    String? profilePhoto,
    int? commentCount,
    int? shareCount,
  }) {
    return PostVideo(
      userName: userName ?? this.userName,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      likes: likes ?? this.likes,
      songName: songName ?? this.songName,
      caption: caption ?? this.caption,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'id': id,
      'uid': uid,
      'likes': likes,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'profilePhoto': profilePhoto,
      'commentCount': commentCount,
      'shareCount': shareCount,
    };
  }

  factory PostVideo.fromMap(Map<String, dynamic> map) {
    return PostVideo(
      userName: map['userName'] as String,
      id: map['id'] as String,
      uid: map['uid'] as String,
      likes: List.from((map['likes'] as List)),
      songName: map['songName'] as String,
      caption: map['caption'] as String,
      videoUrl: map['videoUrl'] as String,
      thumbnail: map['thumbnail'] as String,
      profilePhoto: map['profilePhoto'] as String,
      commentCount: map['commentCount'] as int,
      shareCount: map['shareCount'] as int,
    );
  }

  @override
  String toString() {
    return 'PostVideo(userName: $userName, id: $id, uid: $uid, likes: $likes, songName: $songName, caption: $caption, videoUrl: $videoUrl, thumbnail: $thumbnail, profilePhoto: $profilePhoto, commentCount: $commentCount, shareCount: $shareCount)';
  }

  @override
  bool operator ==(covariant PostVideo other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.id == id &&
        other.uid == uid &&
        listEquals(other.likes, likes) &&
        other.songName == songName &&
        other.caption == caption &&
        other.videoUrl == videoUrl &&
        other.thumbnail == thumbnail &&
        other.profilePhoto == profilePhoto &&
        other.commentCount == commentCount &&
        other.shareCount == shareCount;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        id.hashCode ^
        uid.hashCode ^
        likes.hashCode ^
        songName.hashCode ^
        caption.hashCode ^
        videoUrl.hashCode ^
        thumbnail.hashCode ^
        profilePhoto.hashCode ^
        commentCount.hashCode ^
        shareCount.hashCode;
  }
}
