import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/provider/firebaseProvider.dart';
import 'package:tiktok_clone/provider/storage_provider.dart';
import 'package:tiktok_clone/repository/auth_repository.dart';
import 'package:tiktok_clone/utl.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final authStateProvider = StreamProvider(
    (ref) => ref.watch(authControllerProvider.notifier).authStateChange);
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.read(authRepositoryProvider),
        ref: ref,
        auth: ref.read(authProvider),
        storageRepository: ref.read(storageRepositoryProvider)));
final searchUserProvider = StreamProvider.family(
  (ref, String query) =>
      ref.watch(authControllerProvider.notifier).searchUser(query),
);
final userDataProvider = StreamProvider.family((ref, String uid) =>
    ref.watch(authControllerProvider.notifier).getUserData(uid));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  final FirebaseAuth _auth;
  final StorageRepository _storageRepository;
  AuthController(
      {required AuthRepository authRepository,
      required Ref ref,
      required FirebaseAuth auth,
      required StorageRepository storageRepository})
      : _auth = auth,
        _authRepository = authRepository,
        _storageRepository = storageRepository,
        _ref = ref,
        super(false);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  void signInUser({
    required String userName,
    required String email,
    required String password,
    required BuildContext context,
    File? file,
  }) async {
    try {
      if (userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        state = true; // Set loading state to true

        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        String? profilePic;
        if (file != null) {
          final res = await _storageRepository.storeFiles(
              path: 'profilePic', id: userCredential.user!.uid, file: file);

          res.fold((l) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l.message),
              ),
            );
            state = false; // Set loading state back to false on error
          }, (r) => profilePic = r);
        }

        UserModel userModel = UserModel(
            name: userName,
            profilePic: profilePic ?? Constants.avatarDefault,
            email: email,
            uid: userCredential.user!.uid);

        final result = await _authRepository.signInUser(userModel);

        state = false; // Set loading state back to false after registration

        result.fold(
          (l) {
            showSnackBar(context, l.message);
          },
          (r) {
            showSnackBar(context, "Register Successfully");
            _ref.read(userProvider.notifier).update((state) => r);
            Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
        );
      } else {
        showSnackBar(context, "Error in Registering\nPlease Enter all details");
      }
    } catch (e) {
      state = false; // Set loading state back to false on any exception
      showSnackBar(context, "Error: $e");
    }
  }

  void loginInUser(String email, String password, BuildContext context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        showSnackBar(context, "Logged in successfully");
      }
    } catch (e) {
      showSnackBar(context, "Error logging  in\n${e.toString()} ");
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<List<UserModel>> searchUser(String query) {
    return _authRepository.getUseOnSearch(query);
  }

  void logout() async {
    _auth.signOut();
  }
}
