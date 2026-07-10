import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/manager/app_state_manager.dart';
import 'package:emombti/manager/connectivity_manager.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:emombti/manager/sync_manager.dart';
import 'package:emombti/ui/chat/view_models/chat_ai_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAppChangeNotifers extends StatelessWidget {
  const MainAppChangeNotifers({
    super.key,
    required this.child,
    required this.storageManager,
    required this.repositoryManager,
    required this.appStateManager,
    required this.connectivityManager,
    required this.syncManager,
  });

  final Widget child;

  final StorageManager storageManager;
  final RepositoryManager repositoryManager;
  final AppStateManager appStateManager;
  final ConnectivityManager connectivityManager;
  final SyncManager syncManager;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: appStateManager.authState,
      child: ChangeNotifierProvider.value(
        value: storageManager,
        child: Consumer<StorageManager>(
          builder: (context, value, _) => MultiProvider(
            providers: [
              Provider<PocketBaseService>.value(
                value: storageManager.pocketBaseService,
              ),
              Provider<FirestoreService>.value(
                value: storageManager.firestoreService,
              ),
              Provider<LocalStorage>.value(value: storageManager.localStorage),
            ],
            child: ChangeNotifierProvider.value(
              value: repositoryManager,
              child: Consumer<RepositoryManager>(
                builder: (context, value, _) => MultiProvider(
                  providers: [
                    Provider<AuthRepository>.value(
                      value: repositoryManager.authRepository,
                    ),
                    Provider<UserRepository>.value(
                      value: repositoryManager.userRepository,
                    ),
                    Provider<ChatRepository>.value(
                      value: repositoryManager.chatRepository,
                    ),
                    Provider<FeedRepository>.value(
                      value: repositoryManager.feedRepository,
                    ),
                    Provider<ContentRepository>.value(
                      value: repositoryManager.contentRepository,
                    ),
                    Provider<SocialRepository>.value(
                      value: repositoryManager.socialRepository,
                    ),
                    Provider<QuizRepository>.value(
                      value: repositoryManager.quizRepository,
                    ),
                    Provider<UserAvatarUpdateUseCase>(
                      lazy: true,
                      create: (context) => UserAvatarUpdateUseCase(
                        userRepository: repositoryManager.userRepository,
                      ),
                    ),
                  ],
                  child: ChangeNotifierProvider.value(
                    value: appStateManager,
                    child: Consumer<AppStateManager>(
                      builder: (context, value, _) {
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(
                              value: appStateManager.appConfig,
                            ),
                            ChangeNotifierProvider.value(
                              value: appStateManager.themeState,
                            ),
                            ChangeNotifierProvider.value(
                              value: appStateManager.appNavBarState,
                            ),
                            ChangeNotifierProvider.value(
                              value: appStateManager.surveyFlowState,
                            ),
                            ChangeNotifierProvider.value(
                              value: appStateManager.chatState,
                            ),
                            ChangeNotifierProvider<ChatAiViewModel>(
                              create: (context) => ChatAiViewModel(
                                authState: appStateManager.authState,
                                chatRepository:
                                    repositoryManager.chatRepository,
                                userRepository:
                                    repositoryManager.userRepository,
                              ),
                            ),
                          ],
                          child: MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(
                                value: connectivityManager,
                              ),
                              ChangeNotifierProvider.value(value: syncManager),
                            ],
                            child: child,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
