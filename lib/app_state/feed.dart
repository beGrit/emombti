import 'package:emombti/domain/models/feed/feed.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';

@immutable
@freezed
abstract class FeedPostState with _$FeedPostState {
  const factory FeedPostState({@Default([]) List<Post> items}) = _FeedPostState;

  const FeedPostState._();
}

@immutable
@freezed
abstract class FeedReelState with _$FeedReelState {
  const factory FeedReelState({@Default([]) List<Reel> items}) = _FeedReelState;

  const FeedReelState._();
}

class FeedPostNotifier extends ValueNotifier<FeedPostState> {
  FeedPostNotifier(super.value);

  void addPost(Post post) {
    value = value.copyWith(items: [post, ...value.items]);
  }

  void setPosts(List<Post> posts) {
    value = value.copyWith(items: posts);
  }

  void insertPosts(List<Post> newPosts) {
    value = value.copyWith(items: [...value.items, ...newPosts]);
  }

  void deletePost(String postId) {
    value = value.copyWith(
      items: value.items.where((post) => post.id != postId).toList(),
    );
  }
}

class FeedReelNotifier extends ValueNotifier<FeedReelState> {
  FeedReelNotifier(super.value);

  void setReels(List<Reel> reels) {
    value = value.copyWith(items: reels);
  }

  void insertReels(List<Reel> newReels) {
    value = value.copyWith(items: [...value.items, ...newReels]);
  }

  void deleteReel(String reelId) {
    value = value.copyWith(
      items: value.items.where((reel) => reel.id != reelId).toList(),
    );
  }
}
