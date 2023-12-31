import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tiktok_clone/failure.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/provider/firebaseProvider.dart';
import 'package:tiktok_clone/typedef.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(firestore: ref.read(firestoreProvider)),
);

class AuthRepository {
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  FutureEither<UserModel?> signInUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('user')
          .doc(userModel.uid)
          .set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _firestore.collection('user').doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  Stream<List<UserModel>> getUseOnSearch(String query) {
    return _firestore
        .collection('user')
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),
        )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var user in event.docs) {
        users.add(
          UserModel.fromMap(user.data()),
        );
      }
      return users;
    });
  }
}
