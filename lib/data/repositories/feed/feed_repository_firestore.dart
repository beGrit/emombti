import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/services/persistence/api/file_service.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/activity/activity_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/feed/feed_api_model.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:uuid/uuid.dart';

class FeedRepositoryFirestore extends FeedRepository {
  final FirestoreService firestoreService;
  final FileService fileService;
  final Map<String, DocumentSnapshot> _snapshotCache = {};

  FeedRepositoryFirestore({
    required this.firestoreService,
    required this.fileService,
  });

  @override
  Future<Result<Post>> createPost(Post post) async {
    DateTime now = DateTime.now();
    post = post.copyWith(id: Uuid().v4(), created: now, updated: now);
    await firestoreService.savePost(_mapPostDomainToApiModel(post));

    // Save user activity for the created post
    final userId = post.author.id;
    if (userId != null && userId.isNotEmpty) {
      await firestoreService.saveUserActivity(
        userId,
        ActivityApiModel(
          title: post.title ?? 'New Post',
          description: post.body,
          relatedId: post.id,
          type: 'post',
          thumbnailUrl: post.photos.isNotEmpty
              ? post.photos.first.uri.toString()
              : null,
          createdAt: now,
        ),
      );
    }

    return Result.ok(post);
  }

  @override
  Future<Result<Post>> getPostById(String id) async {
    var apiModel = await firestoreService.getPost(id);
    if (apiModel == null) {
      return Result.error(Exception('Post not found.'));
    } else {
      return Result.ok(_mapPostApiModelToDomain(apiModel));
    }
  }

  @override
  Future<Result<List<Post>>> getPostsLimit(
    int? limit,
    String? postId,
    String? userId,
  ) async {
    try {
      DocumentSnapshot? lastDocument;
      if (postId != null) {
        if (!_snapshotCache.containsKey(postId)) {
          _snapshotCache[postId] = await firestoreService.getFeedSnapshot(
            postId,
          );
        }
        lastDocument = _snapshotCache[postId];
      }
      List<PostApiModel> apiModels = await firestoreService.getPosts(
        limit: limit,
        lastDocument: lastDocument,
        desc: true,
      );
      return Result.ok(
        apiModels.map((e) => _mapPostApiModelToDomain(e)).toList(),
      );
    } catch (e) {
      return Result.error(Exception('Failed to load posts.'));
    }
  }

  @override
  Future<Result<Reel>> createReel(Reel reel) async {
    DateTime now = DateTime.now();
    reel = reel.copyWith(id: Uuid().v4(), created: now, updated: now);
    await firestoreService.saveReel(_mapReelDomainToApiModel(reel));

    // Save user activity for the created reel
    final userId = reel.author.id;
    if (userId != null && userId.isNotEmpty) {
      await firestoreService.saveUserActivity(
        userId,
        ActivityApiModel(
          title: reel.title ?? 'New Reel',
          description: reel.subTitle,
          relatedId: reel.id,
          type: 'reel',
          thumbnailUrl: reel.videoUrl.uri.toString(),
          createdAt: now,
        ),
      );
    }

    return Result.ok(reel);
  }

  @override
  Future<Result<Reel>> getReelById(String id) async {
    var apiModel = await firestoreService.getReel(id);
    if (apiModel == null) {
      return Result.error(Exception('Reel not found.'));
    } else {
      return Result.ok(_mapReelApiModelToDomain(apiModel));
    }
  }

  @override
  Future<Result<List<Reel>>> getReelsLimit(
    int? limit,
    String? reelId,
    String? userId,
  ) async {
    try {
      DocumentSnapshot? lastDocument;
      if (reelId != null) {
        if (!_snapshotCache.containsKey(reelId)) {
          _snapshotCache[reelId] = await firestoreService.getFeedSnapshot(
            reelId,
          );
        }
        lastDocument = _snapshotCache[reelId];
      }
      List<ReelApiModel> apiModels = await firestoreService.getReels(
        limit: limit,
        lastDocument: lastDocument,
        desc: true,
      );
      return Result.ok(
        apiModels.map((e) => _mapReelApiModelToDomain(e)).toList(),
      );
    } catch (e) {
      return Result.error(Exception('Failed to load reels.'));
    }
  }

  @override
  Future<Result<AppFile>> uploadImageForPost(
    String name,
    List<int> bytes,
  ) async {
    try {
      String objectName = 'feed/posts/$name';
      await fileService.saveFile(objectName, bytes, name);
      Uri uri = fileService.getUri(objectName);
      return Result.ok(AppFile(uri: uri, name: name));
    } catch (e) {
      return Result.error(Exception('Upload failed.'));
    }
  }

  @override
  Future<Result<AppFile>> uploadVideoForReel(
    String name,
    List<int> bytes,
  ) async {
    try {
      String objectName = 'feed/reels/$name';
      await fileService.saveFile(objectName, bytes, name);
      Uri uri = fileService.getUri(objectName);
      return Result.ok(AppFile(uri: uri, name: name));
    } catch (e) {
      return Result.error(Exception('Upload failed.'));
    }
  }

  PostApiModel _mapPostDomainToApiModel(Post post) {
    return PostApiModel(
      id: post.id ?? '',
      author: post.author.id ?? '',
      feedType: post.feedType.name,
      title: post.title ?? '',
      body: post.body,
      photos: post.photos.map((e) => e.toJson()).toList(),
      created: post.created,
      updated: post.updated,
    );
  }

  Post _mapPostApiModelToDomain(PostApiModel apiModel) {
    return Post(
      id: apiModel.id,
      feedType: FeedType.post,
      title: apiModel.title,
      body: apiModel.body,
      photos: apiModel.photos.map((e) => AppFile.fromJson(e)).toList(),
      author: User(id: apiModel.author),
      created: apiModel.created,
      updated: apiModel.updated,
    );
  }

  ReelApiModel _mapReelDomainToApiModel(Reel post) {
    return ReelApiModel(
      id: post.id ?? '',
      title: post.title ?? '',
      subTitle: post.subTitle ?? '',
      author: post.author.id ?? '',
      feedType: post.feedType.name,
      video: post.videoUrl.toJson(),
      created: post.created,
      updated: post.updated,
    );
  }

  Reel _mapReelApiModelToDomain(ReelApiModel apiModel) {
    return Reel(
      id: apiModel.id,
      title: apiModel.title,
      subTitle: apiModel.subTitle,
      feedType: FeedType.reel,
      videoUrl: AppFile.fromJson(apiModel.video),
      author: User(id: apiModel.author),
      created: apiModel.created,
      updated: apiModel.updated,
    );
  }
}
