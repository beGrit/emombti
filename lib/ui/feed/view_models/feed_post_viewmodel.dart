import 'dart:async';
import 'dart:convert';

import 'package:emombti/app_state/feed.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class FeedPostViewModel extends ChangeNotifier {
  final FeedRepository _feedRepository;
  final UserRepository _userRepository;
  final FeedPostNotifier _feedPostNotifier;

  FeedPostViewModel({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
    required UserRepository userRepository,
    required FeedPostNotifier feedPostNotifier,
  }) : _feedRepository = feedRepository,
       _userRepository = userRepository,
       _feedPostNotifier = feedPostNotifier {
    loadPostsCommand = Command0<List<Post>>(_loadPostsInternal);
    loadMorePostsCommand = Command0<List<Post>>(_loadMorePostsInternal);
  }

  static const int _perPage = 5;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  late final Command0<List<Post>> loadPostsCommand;
  late final Command0<List<Post>> loadMorePostsCommand;

  Future<Result<List<Post>>> _loadPostsInternal() async {
    _hasMore = true;
    // Fetches the first page of posts (paginated)
    final result = await _feedRepository.getPostsLimit(_perPage, null, null);

    switch (result) {
      case Ok<List<Post>>():
        final posts = await _loadUsers(result.value);
        _feedPostNotifier.setPosts(posts);
        if (result.value.length < _perPage) {
          _hasMore = false;
        }
      case Error<List<Post>>():
        break;
    }
    return result;
  }

  Future<Result<List<Post>>> _loadMorePostsInternal() async {
    if (!_hasMore) return Result.ok([]);
    var posts = _feedPostNotifier.value.items;

    final result = await _feedRepository.getPostsLimit(
      _perPage,
      posts[posts.length - 1].id,
      null,
    );

    switch (result) {
      case Ok<List<Post>>():
        final newPosts = await _loadUsers(result.value);
        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          _feedPostNotifier.insertPosts(newPosts);
          if (newPosts.length < _perPage) {
            _hasMore = false;
          }
        }
      case Error<List<Post>>():
        break;
    }
    return result;
  }

  /// Adds a newly created post to the top of the feed list.
  void addPost(Post post) {
    _feedPostNotifier.addPost(post);
  }

  String paraseBody(String? initialJson) {
    if (initialJson == null) return '';
    return Document.fromJson(jsonDecode(initialJson)).toPlainText();
  }

  Future<List<Post>> _loadUsers(List<Post> posts) async {
    List<String> userIds = [];
    userIds.addAll(
      posts.map((e) => e.author.id != null ? e.author.id! : '').toList(),
    );
    Result res = await _userRepository.getUsersByIds(userIds);
    if (res is Ok) {
      Map<String, User> usersMap = {};
      List<User> userList = res.value;
      for (var user in userList) {
        if (user.id != null) {
          usersMap[user.id!] = user;
        }
      }
      posts = posts.map((post) {
        User? newAuthor = usersMap[post.author.id];
        return post.copyWith(author: newAuthor ?? post.author);
      }).toList();
      return posts;
    }
    return [];
  }
}
