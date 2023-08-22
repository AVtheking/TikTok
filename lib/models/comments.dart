// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class Comments {
  final String username;
  final String id;
  final String uid;
  final String profilePic;
  final String comment;
  final DateTime createdAt;
  final List likes;
  Comments({
    required this.username,
    required this.id,
    required this.uid,
    required this.profilePic,
    required this.comment,
    required this.createdAt,
    required this.likes,
  });

  Comments copyWith({
    String? username,
    String? id,
    String? uid,
    String? profilePic,
    String? comment,
    DateTime? createdAt,
    List? likes,
  }) {
    return Comments(
      username: username ?? this.username,
      id: id ?? this.id,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'id': id,
      'uid': uid,
      'profilePic': profilePic,
      'comment': comment,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory Comments.fromMap(Map<String, dynamic> map) {
    return Comments(
        username: map['username'] as String,
        id: map['id'] as String,
        uid: map['uid'] as String,
        profilePic: map['profilePic'] as String,
        comment: map['comment'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        likes: List.from(
          (map['likes'] as List),
        ));
  }

  @override
  String toString() {
    return 'Comments(username: $username, id: $id, uid: $uid, profilePic: $profilePic, comment: $comment, createdAt: $createdAt, likes: $likes)';
  }

  @override
  bool operator ==(covariant Comments other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.id == id &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.comment == comment &&
        other.createdAt == createdAt &&
        listEquals(other.likes, likes);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        id.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        comment.hashCode ^
        createdAt.hashCode ^
        likes.hashCode;
  }
}
