import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

enum RelationType { owner, history, share }

enum FeedType { post, reel }

enum FeedEventType { delete, add }

@freezed
abstract class FeedEvent with _$FeedEvent {
  const factory FeedEvent({
    required FeedEventType eventType,
    required FeedType feedType,
    required String feedId,
  }) = _FeedEvent;
}

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
abstract class Post with _$Post {
  const factory Post({
    String? id,
    required FeedType feedType,
    String? title,
    String? body,
    @Default([]) List<AppFile> photos,
    required User author,
    required DateTime created,
    required DateTime updated,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
abstract class Reel with _$Reel {
  const factory Reel({
    String? id,
    required FeedType feedType,
    String? title,
    String? subTitle,
    required AppFile videoUrl,
    required User author,
    required DateTime created,
    required DateTime updated,
  }) = _Reel;

  factory Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);
}
