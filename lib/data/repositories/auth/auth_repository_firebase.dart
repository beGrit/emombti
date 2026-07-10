// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logging/logging.dart';

import '../../../domain/models/common/common.dart';
import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryFirebase extends AuthRepository {
  AuthRepositoryFirebase({
    required FirestoreService apiStroage,
    fb.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) {
    _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;
    _googleSignIn = googleSignIn ?? GoogleSignIn.instance;
    _apiStroage = apiStroage;
  }

  final _log = Logger('AuthRepositoryFirebase');
  late final fb.FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;
  late final FirestoreService _apiStroage;

  Future<User?> _initUser(fb.User? firebaseUser) async {
    if (firebaseUser == null) {
      return null;
    } else {
      UserFirestoreApiModel? apiModel = await _apiStroage.getUser(
        firebaseUser.uid,
      );
      User? user;
      if (apiModel == null) {
        user = User(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          name: firebaseUser.displayName,
          avatar: firebaseUser.photoURL != null
              ? AppFile(uri: Uri.parse(firebaseUser.photoURL!), name: 'avatar')
              : null,
        );
        UserFirestoreApiModel apiModel = UserFirestoreApiModel(
          id: user.id ?? '',
          email: user.email,
          name: user.name,
          mbtiType: user.mbtiType,
          introduce: user.introduce,
          avatar: user.avatar?.uri.toString(),
          created: DateTime.now(),
          updated: DateTime.now(),
        );
        _apiStroage.saveUser(apiModel);
      } else {
        user = User(
          id: apiModel.id,
          email: apiModel.email,
          name: apiModel.name,
          mbtiType: apiModel.mbtiType,
          introduce: apiModel.introduce,
          avatar: apiModel.avatar != null
              ? AppFile(uri: Uri.parse(apiModel.avatar ?? ''), name: '')
              : null,
        );
      }
      return user;
    }
  }

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _initUser(userCredential.user);
      if (user != null) {
        return Result.ok(user);
      } else {
        return Result.error(Exception('Failed to get user after login'));
      }
    } on fb.FirebaseAuthException catch (e) {
      _log.info(e.message);
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final user = await _initUser(userCredential.user);
      if (user != null) {
        return Result.ok(user);
      } else {
        return Result.error(Exception('Failed to get user after Google login'));
      }
    } on fb.FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> loginWithWechat() async {
    return Result.error(Exception('Wechat login not implemented'));
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> loginWithAppleId() async {
    try {
      final appleProvider = fb.AppleAuthProvider();
      fb.UserCredential userCredential;
      if (kIsWeb) {
        userCredential = await fb.FirebaseAuth.instance.signInWithPopup(
          appleProvider,
        );
      } else {
        userCredential = await fb.FirebaseAuth.instance.signInWithProvider(
          appleProvider,
        );
      }
      final user = await _initUser(userCredential.user);
      if (user != null) {
        return Result.ok(user);
      } else {
        return Result.error(Exception('Failed to get user after Apple login'));
      }
    } on fb.FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> fetchAuthenticatedUser() async {
    final fbUser = _firebaseAuth.currentUser;
    if (fbUser != null) {
      User? user;
      try {
        user = await _initUser(fbUser);
      } catch (e) {
        return Result.error(Exception(e.toString()));
      }
      if (user != null) {
        return Result.ok(user);
      }
    }
    return Result.error(Exception('No authenticated user'));
  }

  @override
  Future<Result<User>> register({
    required String email,
    required String password,
  }) async {
    try {
      fb.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = await _initUser(userCredential.user);
      if (user != null) {
        return Result.ok(user);
      } else {
        return Result.error(Exception('Failed to register.'));
      }
    } catch (e) {
      return Result.error(Exception('Failed to register.'));
    }
  }
}
