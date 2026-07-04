import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';

/// User repository interface responsible for handling basic user information.
abstract class UserRepository {
  /// Fetches basic user information for a specific ID.
  Future<Result<User>> getUser(String id);

  Future<Result<User>> getRobot(String id);

  /// Fetches a user by their email address. Returns null if no user is found.
  Future<Result<User?>> getUserByEmail(String email);

  /// Searches users by name or email keyword.
  Future<Result<List<User>>> searchUsers(
    String keyword, {
    String? excludeUserId,
  });

  Future<Result<List<User>>> getUsersByIds(List<String> ids);

  /// Saves or updates core user information.
  Future<Result<void>> saveUser(User user);

  /// Create user.
  Future<Result<void>> createUserUsingEmailPassword({
    required String email,
    required String password,
    String? id,
  });

  /// Updates the user's avatar.
  Future<Result<User>> updateAvatar(
    String id,
    List<int> bytes,
    String filename,
  );

  /// Updates the user's background image.
  Future<Result<User>> updateBackgroundImg(
    String id,
    List<int> bytes,
    String filename,
  );
}
