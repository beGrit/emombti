import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/result.dart';

abstract class FeedRepository {
  Future<Result<List<Post>>> getPostsLimit(
    int? limit,
    String? postId,
    String? userId,
  );

  Future<Result<Post>> getPostById(String id);

  /// Deletes a post by ID.
  Future<Result<void>> deletePostById(String userId, String postId);

  Future<Result<List<Reel>>> getReelsLimit(
    int? limit,
    String? reelId,
    String? userId,
  );

  Future<Result<Reel>> getReelById(String id);

  /// Creates a new post.
  Future<Result<Post>> createPost(Post post);

  Future<Result<Reel>> createReel(Reel reel);

  Future<Result<AppFile>> uploadImageForPost(String name, List<int> bytes);

  Future<Result<AppFile>> uploadVideoForReel(String name, List<int> bytes);
}
