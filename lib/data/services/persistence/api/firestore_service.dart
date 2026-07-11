import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emombti/data/services/persistence/api/model/activity/activity_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/chat/chat_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/feed/feed_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/quiz/quiz_api_model.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:logging/logging.dart';

import 'model/social/social_meta_api_model.dart';
import 'model/user/user_api_model.dart';

class FirestoreService {
  final _log = Logger('FirestoreService');

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  FirebaseFirestore get firestore => _firestore;

  String generateFirestoreId() {
    return _firestore.collection('any_collection').doc().id;
  }

  CollectionReference<Map<String, dynamic>> get _socialMetas =>
      _firestore.collection('social_metas');

  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection('users');

  CollectionReference<Map<String, dynamic>> _userSurveyFlows(String userId) =>
      _users.doc(userId).collection('survey_flows');

  CollectionReference<Map<String, dynamic>> _userActivities(String userId) =>
      _users.doc(userId).collection('activities');

  CollectionReference<Map<String, dynamic>> get _chats =>
      _firestore.collection('chats');

  CollectionReference<Map<String, dynamic>> _userChats(String userId) =>
      _users.doc(userId).collection('chats');

  CollectionReference<Map<String, dynamic>> _chatMessages(String chatId) =>
      _chats.doc(chatId).collection('messages');

  CollectionReference<Map<String, dynamic>> get _feed =>
      _firestore.collection('feed');

  CollectionReference<Map<String, dynamic>> _feedActivityCollection(
    String userId,
    String relationType,
  ) {
    if (relationType == RelationType.owner.name) {
      return _users.doc(userId).collection('owns');
    } else if (relationType == RelationType.history.name) {
      return _users.doc(userId).collection('histories');
    } else if (relationType == RelationType.share.name) {
      return _users.doc(userId).collection('shares');
    }
    throw ArgumentError('Invalid relationType: $relationType');
  }

  Future<DocumentSnapshot> getFeedSnapshot(String feedId) async {
    final doc = await _feed.doc(feedId).get();
    return doc;
  }

  /// Save or update a Post to /feed/{feedId}
  Future<void> savePost(PostApiModel post) async {
    await _feed.doc(post.id).set(post.toJson());
  }

  Future<List<PostApiModel>> getPosts({
    int? limit,
    DocumentSnapshot? lastDocument,
    bool desc = false,
  }) async {
    var query = _feed
        .where('feedType', isEqualTo: 'post')
        .orderBy('created', descending: desc);

    if (limit != null) {
      query = query.limit(limit);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => PostApiModel.fromJson(doc.data()))
        .toList();
  }

  /// Load a Post from /feed/{feedId}
  Future<PostApiModel?> getPost(String feedId) async {
    final doc = await _feed.doc(feedId).get();
    if (!doc.exists || doc.data() == null) return null;
    return PostApiModel.fromJson(doc.data()!);
  }

  /// Save or update a Reel to /feed/{feedId}
  Future<void> saveReel(ReelApiModel reel) async {
    await _feed.doc(reel.id).set(reel.toJson());
  }

  /// Load a Reel from /feed/{feedId}
  Future<ReelApiModel?> getReel(String feedId) async {
    final doc = await _feed.doc(feedId).get();
    if (!doc.exists || doc.data() == null) return null;
    return ReelApiModel.fromJson(doc.data()!);
  }

  Future<List<ReelApiModel>> getReels({
    int? limit,
    DocumentSnapshot? lastDocument,
    bool desc = false,
  }) async {
    var query = _feed
        .where('feedType', isEqualTo: 'reel')
        .orderBy('created', descending: desc);

    if (limit != null) {
      query = query.limit(limit);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => ReelApiModel.fromJson(doc.data()))
        .toList();
  }

  /// Save or update a FeedActivity depending on its relationType
  /// Saved to /users/{userId}/owns, /users/{userId}/histories, or /users/{userId}/shares
  Future<void> saveFeedActivity({
    required String userId,
    required FeedActivityApiModel activity,
  }) async {
    final collection = _feedActivityCollection(userId, activity.relationType);
    await collection.doc(activity.id).set(activity.toJson());
  }

  /// Load a FeedActivity from a specific user and relation collection
  Future<FeedActivityApiModel?> getFeedActivity({
    required String userId,
    required String activityId,
    required RelationType relationType,
  }) async {
    final collection = _feedActivityCollection(userId, relationType.name);
    final doc = await collection.doc(activityId).get();
    if (!doc.exists || doc.data() == null) return null;
    return FeedActivityApiModel.fromJson(doc.data()!);
  }

  /// Load all FeedActivities of a specific relation type for a user
  Future<List<FeedActivityApiModel>> getFeedActivities({
    required String userId,
    required RelationType relationType,
  }) async {
    final collection = _feedActivityCollection(userId, relationType.name);
    final query = await collection.get();
    return query.docs
        .map((doc) => FeedActivityApiModel.fromJson(doc.data()))
        .toList();
  }

  Future<List<ActivityApiModel>> getUserActivities(String userId) async {
    final query = await _userActivities(
      userId,
    ).orderBy('createdAt', descending: true).get();

    return query.docs
        .map(
          (doc) => ActivityApiModel.fromJson(doc.data()).copyWith(id: doc.id),
        )
        .toList();
  }

  /// Get user activities with optional limit and pagination by lastActivityId
  Future<List<ActivityApiModel>> getUserActivitiesLimit(
    String userId, {
    int? limit,
    String? lastActivityId,
  }) async {
    var collection = _userActivities(
      userId,
    ).orderBy('createdAt', descending: true);

    if (limit != null) {
      collection = collection.limit(limit);
    }

    if (lastActivityId != null && lastActivityId.isNotEmpty) {
      final lastDoc = await _userActivities(userId).doc(lastActivityId).get();
      if (lastDoc.exists) {
        collection = collection.startAfterDocument(lastDoc);
      }
    }

    final querySnapshot = await collection.get();

    return querySnapshot.docs
        .map(
          (doc) => ActivityApiModel.fromJson(doc.data()).copyWith(id: doc.id),
        )
        .toList();
  }

  /// Save or update a user activity at /user/{userId}/activities/{activityId}
  Future<void> saveUserActivity(
    String userId,
    ActivityApiModel activity,
  ) async {
    try {
      var model = activity;
      if (model.id == null || model.id!.isEmpty) {
        model = model.copyWith(id: generateFirestoreId());
      }

      final docRef = _userActivities(userId).doc(model.id);
      final data = model.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();

      await docRef.set(data, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a user activity by relatedId at /user/{userId}/activities/{activityId}
  /// Delete a feed post and its associated activity from user collections
  Future<void> deleteFeedAndActivity({
    required String feedId,
    required String userId,
    required String type,
  }) async {
    final batch = _firestore.batch();
    batch.delete(_feed.doc(feedId));
    final querySnapshot = await _userActivities(userId)
        .where('type', isEqualTo: type)
        .where('relatedId', isEqualTo: feedId)
        .get();

    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  /// Save or update user profile data at /users/{uid}
  Future<UserFirestoreApiModel> saveUser(UserFirestoreApiModel user) async {
    final docRef = _users.doc(user.id);
    await docRef.set(
      user.toJson()..removeWhere((key, value) => value == null),
      SetOptions(merge: true),
    );
    return user;
  }

  /// Search users by name or email keyword.
  Future<List<UserFirestoreApiModel>> searchUsers(
    String keyword, {
    int limit = 20,
    String? excludeUserId,
  }) async {
    final query = keyword.trim();
    if (query.isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase();
    final end = '$query\uf8ff';
    final candidates = <String, UserFirestoreApiModel>{};

    Future<void> addFromQuery(
      Query<Map<String, dynamic>> firestoreQuery,
    ) async {
      final snapshot = await firestoreQuery.limit(limit).get();
      for (final doc in snapshot.docs) {
        if (excludeUserId != null && doc.id == excludeUserId) {
          continue;
        }

        try {
          candidates[doc.id] = UserFirestoreApiModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          });
        } catch (_) {}
      }
    }

    await Future.wait([
      addFromQuery(
        _users
            .where('name', isGreaterThanOrEqualTo: query)
            .where('name', isLessThanOrEqualTo: end),
      ),
      addFromQuery(
        _users
            .where('email', isGreaterThanOrEqualTo: query)
            .where('email', isLessThanOrEqualTo: end),
      ),
    ]);

    return candidates.values
        .where((user) {
          final name = user.name?.toLowerCase() ?? '';
          final email = user.email?.toLowerCase() ?? '';
          return name.contains(lowerQuery) || email.contains(lowerQuery);
        })
        .take(limit)
        .toList();
  }

  /// Fetch user profile data from /users/{uid}
  Future<UserFirestoreApiModel?> getUser(String uid) async {
    final snapshot = await _users.doc(uid).get();
    final data = snapshot.data();

    if (!snapshot.exists || data == null) {
      return null;
    }

    try {
      final apiModel = UserFirestoreApiModel.fromJson(data);
      return apiModel;
    } catch (_) {
      return null;
    }
  }

  Future<List<UserFirestoreApiModel>> getUsersByIds(List<String> ids) async {
    if (ids.isEmpty) {
      return [];
    }
    final List<DocumentSnapshot<Map<String, dynamic>>> results = [];
    final List<String> missingFromServerIds = [];

    // load from local cache.
    for (String id in ids) {
      try {
        final doc = await _users
            .doc(id)
            .get(const GetOptions(source: Source.cache));

        if (doc.exists && doc.data() != null) {
          results.add(doc);
        } else {
          missingFromServerIds.add(id);
        }
      } catch (e) {
        missingFromServerIds.add(id);
      }
    }

    if (missingFromServerIds.isNotEmpty) {
      const int chunkSize = 30;
      for (var i = 0; i < missingFromServerIds.length; i += chunkSize) {
        final chunk = missingFromServerIds.sublist(
          i,
          i + chunkSize > missingFromServerIds.length
              ? missingFromServerIds.length
              : i + chunkSize,
        );

        try {
          final querySnapshot = await _users
              .where(FieldPath.documentId, whereIn: chunk)
              .get(const GetOptions(source: Source.server));

          results.addAll(querySnapshot.docs);
        } catch (e) {
          _log.severe('Firestore line fetch error for chunk $chunk: $e');
        }
      }
    }

    return results
        .map((e) {
          final data = e.data();
          if (data == null) return null;
          return UserFirestoreApiModel.fromJson(data);
        })
        .whereType<UserFirestoreApiModel>()
        .toList();
  }

  /// Get social meta by related ID (e.g., PocketBase post ID)
  Future<SocialMetaApiModel?> getSocialMetaByRelatedId(String relatedId) async {
    final query = await _socialMetas
        .where('relatedId', isEqualTo: relatedId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return SocialMetaApiModel.fromJson(doc.data()).copyWith(id: doc.id);
  }

  /// Create a new social meta for a related ID
  Future<SocialMetaApiModel> createSocialMeta(String relatedId) async {
    final docRef = _socialMetas.doc();
    final now = DateTime.now();

    final socialMeta = SocialMetaApiModel(
      relatedId: relatedId,
      metrics: const SocialMetricsApiModel(),
      created: now,
      updated: now,
    );

    final data = socialMeta.toJson();
    // Use server timestamps for accuracy
    data['created'] = FieldValue.serverTimestamp();
    data['updated'] = FieldValue.serverTimestamp();

    await docRef.set(data);

    return socialMeta.copyWith(id: docRef.id);
  }

  /// Toggle like status for a user
  Future<void> toggleLike({
    required String socialMetaId,
    required String userId,
    required bool shouldLike,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final likeRef = docRef.collection('likes').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final likeSnapshot = await transaction.get(likeRef);
      final exists = likeSnapshot.exists;

      if (shouldLike && !exists) {
        transaction.set(likeRef, {
          'userId': userId,
          'created': FieldValue.serverTimestamp(),
        });
        transaction.update(docRef, {
          'metrics.likes': FieldValue.increment(1),
          'updated': FieldValue.serverTimestamp(),
        });
      } else if (!shouldLike && exists) {
        transaction.delete(likeRef);
        transaction.update(docRef, {
          'metrics.likes': FieldValue.increment(-1),
          'updated': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  /// Toggle favorite status for a user
  Future<void> toggleFavorite({
    required String socialMetaId,
    required String userId,
    required bool shouldFavorite,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final favRef = docRef.collection('favorites').doc(userId);

    await _firestore.runTransaction((transaction) async {
      final favSnapshot = await transaction.get(favRef);
      final exists = favSnapshot.exists;

      if (shouldFavorite && !exists) {
        transaction.set(favRef, {
          'userId': userId,
          'created': FieldValue.serverTimestamp(),
        });
        transaction.update(docRef, {
          'metrics.favorites': FieldValue.increment(1),
          'updated': FieldValue.serverTimestamp(),
        });
      } else if (!shouldFavorite && exists) {
        transaction.delete(favRef);
        transaction.update(docRef, {
          'metrics.favorites': FieldValue.increment(-1),
          'updated': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  /// Add a comment
  Future<CommentApiModel> addComment({
    required String socialMetaId,
    required CommentApiModel comment,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);
    final commentRef = docRef.collection('comments').doc();

    final data = comment.toJson();
    data['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.runTransaction((transaction) async {
      transaction.set(commentRef, data);
      transaction.update(docRef, {
        'metrics.comments': FieldValue.increment(1),
        'updated': FieldValue.serverTimestamp(),
      });
    });

    return comment.copyWith(id: commentRef.id);
  }

  /// Get comments for a social meta
  Future<List<CommentApiModel>> getComments(String socialMetaId) async {
    final query = await _socialMetas
        .doc(socialMetaId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => CommentApiModel.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  /// Get comments for a social meta using pagination (Cursor-based)
  ///
  /// Pass [lastDocument] from the previous page's result to load the next page.
  /// If [lastDocument] is null, it fetches the very first page.
  Future<({List<CommentApiModel> comments, DocumentSnapshot? lastDocument})>
  getCommentsByPage({
    required String socialMetaId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    // 1. Build the base query ordered by creation time
    var query = _socialMetas
        .doc(socialMetaId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .limit(limit);

    // 2. If a cursor document exists, instruct the query to start after it
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    // 3. Fetch the documents from Firestore
    final querySnapshot = await query.get();

    // 4. Map snapshots to your data model
    final comments = querySnapshot.docs.map((doc) {
      return CommentApiModel.fromJson(doc.data()).copyWith(id: doc.id);
    }).toList();

    // 5. Identify the new cursor document (last item fetched) to pass back to the UI
    final newLastDocument = querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.last
        : null;

    // Returns a Dart Record containing both the models and the cursor snapshot
    return (comments: comments, lastDocument: newLastDocument);
  }

  /// Check user interaction status
  Future<Map<String, bool>> getUserStatus({
    required String socialMetaId,
    required String userId,
  }) async {
    final docRef = _socialMetas.doc(socialMetaId);

    final results = await Future.wait([
      docRef.collection('likes').doc(userId).get(),
      docRef.collection('favorites').doc(userId).get(),
    ]);

    return {'isLiked': results[0].exists, 'isFavorited': results[1].exists};
  }

  Future<void> saveSurveyFlow(
    String userId,
    SurveyFlowApiModel surveyFlow,
  ) async {
    try {
      if (surveyFlow.id == null) {
        surveyFlow = surveyFlow.copyWith(id: generateFirestoreId());
      }

      final DocumentReference docRef = _userSurveyFlows(
        userId,
      ).doc(surveyFlow.id);

      await _firestore.runTransaction((transaction) async {
        transaction.set(docRef, surveyFlow.toJson(), SetOptions(merge: true));
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<SurveyFlowApiModel?> getSurveyFlow(
    String userId,
    String flowId,
  ) async {
    final doc = await _userSurveyFlows(userId).doc(flowId).get();
    if (!doc.exists || doc.data() == null) return null;
    final model = SurveyFlowApiModel.fromJson(doc.data()!);
    if (model.deleted == true) return null;
    return model;
  }

  Future<List<SurveyFlowApiModel>> getSurveyFlows(String userId) async {
    final query = await _userSurveyFlows(
      userId,
    ).where('deleted', isNotEqualTo: true).get();
    return query.docs
        .map((doc) => SurveyFlowApiModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> deleteSurveyFlow(String userId, String flowId) async {
    final DocumentReference docRef = _userSurveyFlows(userId).doc(flowId);

    await _firestore.runTransaction((transaction) async {
      transaction.update(docRef, {'deleted': true});
    });
  }

  Future<void> saveAssessmentResult(
    String userId,
    String surveyFlowId,
    AssessmentResultApiModel result,
  ) async {
    try {
      final DocumentReference docRef = _userSurveyFlows(
        userId,
      ).doc(surveyFlowId).collection('contents').doc('result');

      await _firestore.runTransaction((transaction) async {
        transaction.set(docRef, result.toJson());
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<AssessmentResultApiModel?> getAssessmentResult(
    String userId,
    String surveyFlowId,
  ) async {
    final doc = await _userSurveyFlows(
      userId,
    ).doc(surveyFlowId).collection('contents').doc('result').get();
    if (!doc.exists || doc.data() == null) return null;
    return AssessmentResultApiModel.fromJson(doc.data()!);
  }

  Future<List<AssessmentResultApiModel>> getAllAssessmentResults(
    String userId,
  ) async {
    final flows = await getSurveyFlows(userId);
    final results = await Future.wait(
      flows.map((flow) => getAssessmentResult(userId, flow.id!)),
    );
    return results.whereType<AssessmentResultApiModel>().toList();
  }

  UserChatFirestoreApiModel _parseUserChatDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('chatId', () => doc.id);
    return UserChatFirestoreApiModel.fromJson(data);
  }

  ChatFirestoreApiModel _parseChatDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('chatId', () => doc.id);
    return ChatFirestoreApiModel.fromJson(data);
  }

  ChatMessageFirestoreApiModel _parseMessageDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = Map<String, dynamic>.from(doc.data() ?? {});
    data.putIfAbsent('messageId', () => doc.id);
    return ChatMessageFirestoreApiModel.fromJson(data).copyWith(id: doc.id);
  }

  /// Fetch all chat metadata for a user from /users/{userId}/chats.
  Future<List<UserChatFirestoreApiModel>> getUserChats(String userId) async {
    final query = await _userChats(userId).get();
    return query.docs.map(_parseUserChatDoc).toList();
  }

  Future<UserChatFirestoreApiModel> getUserChatByChatId(
    String userId,
    String chatId,
  ) async {
    final query = await _userChats(userId).doc(chatId).get();
    return _parseUserChatDoc(query);
  }

  /// Paginate chat metadata for a user ordered by latest activity.
  Future<
    ({List<UserChatFirestoreApiModel> chats, DocumentSnapshot? lastDocument})
  >
  getUserChatsPaginated({
    required String userId,
    required int limit,
    DocumentSnapshot? lastDocument,
  }) async {
    var query = _userChats(
      userId,
    ).orderBy('lastMessageSentAt', descending: true).limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    final chats = querySnapshot.docs.map(_parseUserChatDoc).toList();
    final newLastDocument = querySnapshot.docs.isNotEmpty
        ? querySnapshot.docs.last
        : null;

    return (chats: chats, lastDocument: newLastDocument);
  }

  /// Fetch chat documents from /chats/{chatId}.
  Future<List<ChatFirestoreApiModel>> getChatsByIds(
    List<String> chatIds,
  ) async {
    if (chatIds.isEmpty) {
      return [];
    }

    final snapshots = await Future.wait(
      chatIds.map(_chats.doc).map((ref) => ref.get()),
    );

    return snapshots
        .where((snapshot) => snapshot.exists)
        .map(_parseChatDoc)
        .toList();
  }

  /// Find an existing 1:1 chat between two users.
  Future<ChatFirestoreApiModel?> findDirectChat({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final List<String> members = [currentUserId, otherUserId]..sort();

    final query = await _chats
        .where('isGroup', isEqualTo: false)
        .where('members', whereIn: [members])
        .get();
    if (query.docs.isNotEmpty) {
      return _parseChatDoc(query.docs[0]);
    }
    return null;
  }

  Future<ChatFirestoreApiModel> createChat(ChatFirestoreApiModel chat) async {
    try {
      await _firestore
          .runTransaction((transaction) async {
            final docRef = _chats.doc(chat.chatId);
            final docSnapshot = await transaction.get(docRef);

            if (docSnapshot.exists) {
              throw Exception('Chat room already exists');
            }

            transaction.set(docRef, chat.toJson());
          })
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('Server write timed out');
            },
          );

      return chat;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, UserChatFirestoreApiModel>> addChatToUsers(
    ChatFirestoreApiModel chat,
  ) async {
    Map<String, UserChatFirestoreApiModel> resultMap = {};
    await _firestore.runTransaction((transaction) async {
      final querySnapshot = await _users
          .where('id', whereIn: chat.members)
          .get();
      final Map<String, UserFirestoreApiModel> userMap = {
        for (var doc in querySnapshot.docs)
          doc.id: UserFirestoreApiModel.fromJson(doc.data()),
      };
      for (String userId in chat.members) {
        String name = '';
        String image = '';

        if (chat.isGroup) {
          name = chat.chatName ?? 'Group Chat';
          image = chat.chatImage ?? '';
        } else {
          final otherUserId = chat.members.firstWhere((id) => id != userId);
          final otherUser = userMap[otherUserId];

          name = otherUser?.name ?? 'User';
          image = otherUser?.avatar ?? '';
        }
        var userChatApiModel = UserChatFirestoreApiModel(
          chatId: chat.chatId,
          name: name,
          image: image,
          unreadCount: 0,
          isPinned: false,
          createdAt: chat.createdAt,
          lastMessageSentAt: null,
          lastMessageText: null,
          lastMessageSenderId: null,
        );
        transaction.set(
          _userChats(userId).doc(chat.chatId),
          userChatApiModel.toJson(),
        );
        resultMap[userId] = userChatApiModel;
      }
    });
    return resultMap;
  }

  /// Delete a chat from the user's active chats subcollection and remove the user from chat members.
  Future<void> deleteUserChat({
    required String userId,
    required String chatId,
  }) async {
    final batch = _firestore.batch();
    batch.delete(_userChats(userId).doc(chatId));
    batch.update(_chats.doc(chatId), {
      'members': FieldValue.arrayRemove([userId]),
    });
    await batch.commit();
  }

  /// Delete the chat document entirely and remove the chat from all members' user-chats.
  Future<void> deleteChat({
    required String chatId,
    required List<String> members,
  }) async {
    await _chats.doc(chatId).delete();
    final batch = _firestore.batch();
    batch.delete(_chats.doc(chatId));
    for (final memberId in members) {
      batch.delete(_userChats(memberId).doc(chatId));
    }
    await batch.commit();
  }

  /// Fetch a single chat document from /chats/{chatId}.
  Future<ChatFirestoreApiModel?> getChat(String chatId) async {
    final snapshot = await _chats.doc(chatId).get();
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return _parseChatDoc(snapshot);
  }

  /// Fetch messages from /chats/{chatId}/messages ordered by sentAt descending.
  Future<List<ChatMessageFirestoreApiModel>> getChatMessages(
    String chatId, {
    int? limit,
    DocumentSnapshot? lastDocument,
    bool desc = false,
  }) async {
    var query = _chatMessages(chatId)
        // .where('status', isEqualTo: 'sent')
        .orderBy('sentAt', descending: desc);

    if (limit != null) {
      query = query.limit(limit);
    }

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map(_parseMessageDoc).toList();
  }

  Future<DocumentSnapshot> getChatMessageSnapshot(
    String chatId,
    String messageId,
  ) async {
    var query = _chatMessages(chatId).doc(messageId);
    DocumentSnapshot ds = await query.get();
    return ds;
  }

  Future<ChatMessageFirestoreApiModel> sendChatMessage({
    required String chatId,
    required ChatMessageFirestoreApiModel message,
  }) async {
    final chatRef = _chats.doc(chatId);

    // Fetching the chat metadata from cache first, then server if unavailable
    final chatSnapshot = await chatRef.get();
    if (!chatSnapshot.exists || chatSnapshot.data() == null) {
      throw Exception('Chat not found');
    }

    final messageRef = message.messageId.isNotEmpty
        ? _chatMessages(chatId).doc(message.messageId)
        : _chatMessages(chatId).doc();

    final messageId = messageRef.id;
    final sentAt = message.sentAt;

    // 1. Prepare data for the server attempt
    final messageData = message
        .copyWith(messageId: messageId, id: messageId, sentAt: sentAt)
        .toJson();
    messageData['sentAt'] = FieldValue.serverTimestamp();

    try {
      // 2. Attempt to save to the remote server
      await messageRef
          .set(messageData)
          .timeout(
            const Duration(seconds: 4),
            onTimeout: () {
              // This forces an error if the server doesn't respond in time
              throw TimeoutException(
                'Server write timed out (likely offline).',
              );
            },
          );
      return message.copyWith(
        messageId: messageId,
        id: messageId,
        sentAt: sentAt,
      );
    } catch (error) {
      // 3. Server write failed. Prepare payload with 'failed' status
      final failedMessage = message.copyWith(status: 'error');

      final failedMessageData = failedMessage.toJson();
      messageRef.set(failedMessageData, SetOptions(merge: true));
      return failedMessage;
    }
  }

  Future<void> updateChatMetaAndUserChats({
    required String chatId,
    required ChatMessageFirestoreApiModel message,
  }) async {
    final chatRef = _chats.doc(chatId);
    final chatSnapshot = await chatRef.get();

    if (!chatSnapshot.exists || chatSnapshot.data() == null) {
      throw Exception('Chat metadata not found');
    }

    final chat = _parseChatDoc(chatSnapshot);
    final batch = _firestore.batch();

    // 1. Update the main chat document's last message info
    batch.set(chatRef, {
      'lastMessage': {
        'text': message.content,
        'senderId': message.senderId,
        'sentAt': FieldValue.serverTimestamp(),
      },
    }, SetOptions(merge: true));

    // 2. Update individual user inbox feeds (userChats)
    for (final memberId in chat.members) {
      final userChatRef = _userChats(memberId).doc(chatId);
      final userChatUpdates = <String, dynamic>{
        'chatId': chatId,
        'lastMessageText': message.content,
        'lastMessageSenderId': message.senderId,
        'lastMessageSentAt': FieldValue.serverTimestamp(),
      };

      if (memberId != message.senderId) {
        userChatUpdates['unreadCount'] = FieldValue.increment(1);
      }

      batch.set(userChatRef, userChatUpdates, SetOptions(merge: true));
    }

    await batch.commit();
  }

  Stream<List<MessageChangeApiModel>> subscribeToChatMessages(String chatId) {
    final listenTime = DateTime.now();
    return _chatMessages(chatId)
        .where('sentAt', isGreaterThan: listenTime)
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docChanges.map((change) {
            final message = _parseMessageDoc(change.doc);

            MessageChangeApiType changeType;
            switch (change.type) {
              case DocumentChangeType.added:
                changeType = MessageChangeApiType.added;
                break;
              case DocumentChangeType.modified:
                changeType = MessageChangeApiType.modified;
                break;
              case DocumentChangeType.removed:
                changeType = MessageChangeApiType.removed;
                break;
            }

            return MessageChangeApiModel(type: changeType, message: message);
          }).toList();
        });
  }

  Stream<ChatConnectionApiModel> monitorChatConnection(String chatId) {
    return _chatMessages(chatId).snapshots(includeMetadataChanges: true).map((
      snapshot,
    ) {
      final isConnected = !snapshot.metadata.isFromCache;
      return ChatConnectionApiModel(isConnected: isConnected);
    }).distinct();
  }
}
