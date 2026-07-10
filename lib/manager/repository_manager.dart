import 'package:emombti/data/repositories/activity/activity_repository.dart';
import 'package:emombti/data/repositories/activity/activity_repository_firestore.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/auth/auth_repository_firebase.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository_dev.dart';
import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/data/repositories/content/content_repository_dev.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository_firestore.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository_dev.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/data/repositories/social/social_repository_firestore.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/data/repositories/user/user_repository_dev.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:flutter/foundation.dart';

class RepositoryManager extends ChangeNotifier {
  late final ActivityRepository activityRepository;
  late final AuthRepository authRepository;
  late final UserRepository userRepository;
  late final ChatRepository chatRepository;
  late final FeedRepository feedRepository;
  late final ContentRepository contentRepository;
  late final SocialRepository socialRepository;
  late final QuizRepository quizRepository;

  Future<void> buildRepositories(StorageManager storageManager) async {
    // Async Typed Repository.
    authRepository = AuthRepositoryFirebase(
      apiStroage: storageManager.firestoreService,
    );
    activityRepository = ActivityRepositoryFirestore(
      firestoreService: storageManager.firestoreService,
    );
    quizRepository = QuizRepositoryDev(
      localStorage: storageManager.localStorage,
      firestoreService: storageManager.firestoreService,
    );
    chatRepository = ChatRepositoryDevV2(
      firestoreService: storageManager.firestoreService,
    );

    // Sync Typed Repository.
    userRepository = UserRepositoryDev(
      firestore: storageManager.firestoreService,
      fileService: storageManager.fileServiceCloudFlare,
    );
    feedRepository = FeedRepositoryFirestore(
      firestoreService: storageManager.firestoreService,
      fileService: storageManager.fileServiceCloudFlare,
    );
    contentRepository = ContentRepositoryDev(
      localStorage: storageManager.localStorage,
    );
    socialRepository = SocialRepositoryFirestore(
      firestoreService: storageManager.firestoreService,
    );

    notifyListeners();
  }
}
