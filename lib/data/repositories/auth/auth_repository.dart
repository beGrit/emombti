// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';

abstract class AuthRepository {
  /// Perform login
  Future<Result<User>> login({required String email, required String password});

  Future<Result<User>> register({
    required String email,
    required String password,
  });

  Future<Result<User>> loginWithWechat();

  Future<Result<User>> loginWithGoogle();

  Future<Result<User>> loginWithAppleId();

  /// Perform logout
  Future<Result<void>> logout();

  /// Fetches the currently authenticated user if any.
  Future<Result<User>> fetchAuthenticatedUser();
}
