import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart'; // 补全你现有的其他全局状态
import 'package:emombti/app_state/feed.dart';
import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/app_state/user_activity.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:emombti/manager/sync_manager.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  late final AppConfig appConfig;
  late final AppNavBarState appNavBarState;
  late final AuthState authState;
  late final QuizState surveyFlowState;
  late final ChatState chatState;
  late final ThemeState themeState;
  late final UserActivityNotifier userActivityNotifier;
  late final FeedPostNotifier feedPostNotifier;
  late final FeedReelNotifier feedReelNotifier;

  late final SyncManager syncManager;
  late final RepositoryManager repositoryManager;

  AppStateManager();

  Future<void> buildAppState({
    required AppConfig appConfig,
    required AuthState authState,
    required ThemeState themeState,
    required StorageManager storageManager,
    required RepositoryManager repositoryManager,
    required SyncManager syncManager,
  }) async {
    this.appConfig = appConfig;
    this.authState = authState;
    this.themeState = themeState;
    this.syncManager = syncManager;
    this.repositoryManager = repositoryManager;

    this.authState.addListener(_onAuthChanged);

    appNavBarState = AppNavBarState();

    // Auto-login check
    final userResult = await repositoryManager.authRepository
        .fetchAuthenticatedUser();
    if (userResult is Ok<User>) {
      authState.updateAuthenticatedUser(userResult.value);
    }

    surveyFlowState = QuizState(repository: repositoryManager.quizRepository);
    chatState = ChatState();

    userActivityNotifier = UserActivityNotifier(const UserActivityState());
    feedPostNotifier = FeedPostNotifier(const FeedPostState());
    feedReelNotifier = FeedReelNotifier(const FeedReelState());

    notifyListeners();
  }

  void _onAuthChanged() {
    if (appConfig.firstBoot == true && authState.isAuthenticated) {
      final job = SyncJob(
        id: 'sync_quiz_${DateTime.now().millisecondsSinceEpoch}',
        key: 'sync_quiz_repository',
        type: SyncType.localToRemote,
        payload: () =>
            repositoryManager.quizRepository.sync(authState.userId ?? ''),
      );
      syncManager.addSyncJob(job, unique: true, override: true);
      appConfig.firstBoot = false;
      appConfig.save();
    }
  }

  @override
  void dispose() {
    authState.removeListener(_onAuthChanged);
    super.dispose();
  }
}
