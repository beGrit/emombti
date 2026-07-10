import 'package:emombti/data/services/persistence/api/file_service.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:quiver/collection.dart';

import 'user_repository.dart';

/// [UserRepository] implementation using PocketBase.
class UserRepositoryDev implements UserRepository {
  final LruMap<String, User> _memoryCache = LruMap<String, User>(
    maximumSize: 200,
  );

  UserRepositoryDev({
    required FirestoreService firestore,
    required FileService fileService,
  }) : _fileService = fileService,
       _firestore = firestore;

  final FirestoreService _firestore;
  final FileService _fileService;

  @override
  Future<Result<void>> createUserUsingEmailPassword({
    required String email,
    required String password,
    String? id,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      UserFirestoreApiModel? apiModel = await _firestore.getUser(id);
      if (apiModel == null) {
        throw Exception('User not found');
      }
      User user = _mapUserApiModelToDomain(apiModel);
      return Result.ok(user);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<User?>> getUserByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<User>>> searchUsers(
    String keyword, {
    String? excludeUserId,
  }) async {
    try {
      final apiModels = await _firestore.searchUsers(
        keyword,
        excludeUserId: excludeUserId,
      );

      final users = apiModels.map(_mapUserApiModelToDomain).toList();

      return Result.ok(users);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<User>>> getUsersByIds(List<String> ids) async {
    if (ids.isEmpty) return Result.ok([]);

    final uniqueIds = ids.toSet().toList();
    final List<User> cachedUsers = [];
    final List<String> missingIds = [];

    for (final id in uniqueIds) {
      if (_memoryCache.containsKey(id)) {
        cachedUsers.add(_memoryCache[id]!);
      } else {
        missingIds.add(id);
      }
    }

    if (missingIds.isEmpty) {
      return Result.ok(_alignAndSortResults(ids, cachedUsers));
    }

    try {
      final List<UserFirestoreApiModel> apiModels = await _firestore
          .getUsersByIds(missingIds);

      final List<User> fetchedUsers = apiModels.map((apiModel) {
        final domainUser = _mapUserApiModelToDomain(apiModel);
        String domainUserId = domainUser.id ?? '';
        if (domainUserId.isNotEmpty) {
          _memoryCache[domainUserId] = domainUser;
        }
        return domainUser;
      }).toList();

      final List<User> allCombinedUsers = [...cachedUsers, ...fetchedUsers];
      return Result.ok(_alignAndSortResults(ids, allCombinedUsers));
    } catch (e) {
      return Result.error(Exception('Failed to load users.'));
    }
  }

  List<User> _alignAndSortResults(List<String> originalIds, List<User> users) {
    final idToUserMap = {for (var user in users) user.id: user};
    return originalIds.map((id) => idToUserMap[id]).whereType<User>().toList();
  }

  @override
  Future<Result<void>> saveUser(User user) async {
    try {
      UserFirestoreApiModel apiModel = UserFirestoreApiModel(
        id: user.id ?? '',
        email: user.email,
        name: user.name,
        mbtiType: user.mbtiType,
        introduce: user.introduce,
        updated: DateTime.now(),
      );
      await _firestore.saveUser(apiModel);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> updateAvatar(
    String id,
    List<int> bytes,
    String filename,
  ) async {
    try {
      String objectName = 'users/avatar/$filename';
      await _fileService.saveFile(objectName, bytes, filename);
      Uri uri = _fileService.getUri(objectName);
      UserFirestoreApiModel apiModel = await _firestore.saveUser(
        UserFirestoreApiModel(
          id: id,
          avatar: uri.toString(),
          updated: DateTime.now(),
        ),
      );
      return Result.ok(_mapUserApiModelToDomain(apiModel));
    } catch (e) {
      return Result.error(Exception('Failed to updateAvatar.'));
    }
  }

  User _mapUserApiModelToDomain(UserFirestoreApiModel apiModel) {
    return User(
      id: apiModel.id,
      email: apiModel.email,
      name: apiModel.name,
      mbtiType: apiModel.mbtiType,
      introduce: apiModel.introduce,
      avatar: apiModel.avatar != null
          ? AppFile(uri: Uri.parse(apiModel.avatar ?? ''), name: '')
          : null,
      backgroundImg: apiModel.backgroundImg != null
          ? AppFile(uri: Uri.parse(apiModel.backgroundImg ?? ''), name: '')
          : null,
    );
  }

  @override
  Future<Result<User>> getRobot(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateBackgroundImg(
    String id,
    List<int> bytes,
    String filename,
  ) async {
    String objectName = 'users/background/$filename';
    await _fileService.saveFile(objectName, bytes, filename);
    Uri uri = _fileService.getUri(objectName);
    UserFirestoreApiModel apiModel = await _firestore.saveUser(
      UserFirestoreApiModel(
        id: id,
        backgroundImg: uri.toString(),
        updated: DateTime.now(),
      ),
    );
    return Result.ok(_mapUserApiModelToDomain(apiModel));
  }
}
