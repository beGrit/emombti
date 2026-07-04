import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:emombti/ui/chat/view_models/chat_ai_viewmodel.dart';
import 'package:emombti/ui/chat/view_models/chat_cloud_viewmodel.dart';
import 'package:emombti/ui/chat/widgets/chat_ai.dart';
import 'package:emombti/ui/chat/widgets/chat_cloud.dart';
import 'package:emombti/ui/chat/widgets/chats.dart';
import 'package:emombti/ui/core/ui/widgets/layout.dart';
import 'package:emombti/ui/core/ui/widgets/under_development.dart';
import 'package:emombti/ui/explore/view_models/explore_viewmodel.dart';
import 'package:emombti/ui/explore/widgets/explore_screen.dart';
import 'package:emombti/ui/feed/view_models/feed_post_detail_viewmodel.dart';
import 'package:emombti/ui/feed/view_models/feed_post_editor_viewmodel.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_editor_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_post_detail.dart';
import 'package:emombti/ui/feed/widgets/feed_post_editor_quill.dart';
import 'package:emombti/ui/feed/widgets/feed_reel_editor.dart';
import 'package:emombti/ui/feed/widgets/feed_viewer_photo.dart';
import 'package:emombti/ui/knowledge/view_models/knowledge_contents_artile_detail_viewmodel.dart';
import 'package:emombti/ui/knowledge/widgets/knowledge_contents_article.dart';
import 'package:emombti/ui/knowledge/widgets/knowledge_contents_screen.dart';
import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_screen.dart';
import 'package:emombti/ui/me/view_models/me_screen_viewmodel.dart';
import 'package:emombti/ui/me/widgets/me_screen.dart';
import 'package:emombti/ui/me/widgets/me_screen_background.dart';
import 'package:emombti/ui/me/widgets/me_screen_feedback.dart';
import 'package:emombti/ui/qr_code/widgets/qr_code_scanner.dart';
import 'package:emombti/ui/quiz/view_models/survey_flow_viewmodel.dart';
import 'package:emombti/ui/quiz/widgets/quiz_landing.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow.dart';
import 'package:emombti/ui/settings/widgets/settings_screen.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:emombti/ui/user/widgets/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

GoRouter router(AuthState authState) => GoRouter(
  initialLocation: Routes.home,
  refreshListenable: authState,
  redirect: _redirect,
  routes: [
    // Login Route
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginScreen(
        viewModel: LoginViewModel(
          repository: context.read(),
          userRepository: context.read(),
          authState: context.read(),
        ),
      ),
    ),
    // Me Standalone Route
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: Routes.userInfo,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final mbtiType = extra?['mbtiType'] as String?;
        return UserInfoScreen(initialMbtiType: mbtiType);
      },
    ),
    GoRoute(
      path: Routes.qRCodeScanner,
      builder: (context, state) => QRCodeScanner(),
    ),
    GoRoute(
      path: Routes.feedback,
      builder: (context, state) => const MeFeedbackScreen(),
    ),
    // Settings Route
    GoRoute(
      path: Routes.meStandalone,
      builder: (context, state) => MeScreen(
        showBackButton: true,
        viewModel: MeViewModel(
          context.read(),
          context.read(),
          context.read(),
          context.read(),
        ),
      ),
    ),
    // Me screen, change background.
    GoRoute(
      name: Routes.meBackground,
      path: Routes.meBackground,
      builder: (context, state) {
        return MeBackgroundPicker(
          viewModel: MeViewModel(
            context.read(),
            context.read(),
            context.read(),
            context.read(),
          ),
        );
      },
    ),
    // Video Detail Route
    GoRoute(
      path: '${Routes.video}/:id',
      builder: (context, state) {
        return const UnderDevelopmentScreen(title: 'Video Detail');
      },
    ),
    GoRoute(
      path: '${Routes.article}/:id',
      builder: (context, state) {
        final articleId = state.pathParameters['id'] ?? '';
        ArticleDetailViewModel viewModel = ArticleDetailViewModel(
          repository: context.read(),
          articleId: articleId,
        );
        viewModel.loadArticleContent.execute();
        SocialViewModel socialViewModel = SocialViewModel(
          repository: context.read(),
          authState: context.read(),
          relatedId: articleId,
        );
        return ArticleDetailScreen(
          viewModel: viewModel,
          socialViewModel: socialViewModel,
        );
      },
    ),
    // Survey Flow Route
    GoRoute(
      path: Routes.surveyFlow,
      builder: (context, state) {
        final surveyId = state.uri.queryParameters['surveyId'] ?? '';
        final flowId = state.uri.queryParameters['flowId'] ?? '';
        return SurveyFlowScreen(
          viewModel: SurveyFlowViewModel(
            repository: context.read(),
            quizState: context.read(),
            authState: context.read(),
            flowId: flowId,
            surveyId: surveyId,
          ),
        );
      },
    ),
    // Survey Result Route
    GoRoute(
      path: '${Routes.surveyResult}/:id',
      builder: (context, state) {
        return const UnderDevelopmentScreen(title: 'Survey Result');
      },
    ),
    GoRoute(
      path: Routes.feedPhotoView,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return FeedPhotoViewScreen(
          imageUrls: extra['imageUrls'] as List<String>,
          initialIndex: extra['initialIndex'] as int,
          heroTag: extra['heroTag'] as String, // Grabbed from extra
        );
      },
    ),
    GoRoute(
      name: Routes.knowledgeContents,
      path: Routes.knowledgeContents,
      builder: (context, state) => const KnowledgeContentsScreen(),
    ),
    GoRoute(
      path: Routes.feedPostEditor,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: FeedPostEditorQuill(
            viewModel: FeedPostEditorViewModel(
              authState: context.read<AuthState>(),
              feedRepository: context.read<FeedRepository>(),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.feedReelEditor,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: FeedReelEditor(
            viewModel: FeedReelEditorViewModel(
              authState: context.read(),
              feedRepository: context.read(),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '${Routes.feedPost}/:id',
      builder: (context, state) {
        final postId = state.pathParameters['id'] ?? '';

        return ChangeNotifierProvider(
          create: (context) => FeedPostDetailViewmodel(
            feedPostId: postId,
            feedRepository: context.read(),
            userRepository: context.read(),
          )..loadPostCommand.execute(),

          child: Consumer<FeedPostDetailViewmodel>(
            builder: (context, viewModel, child) =>
                FeedPostDetail(viewModel: viewModel),
          ),
        );
      },
    ),
    GoRoute(
      path: '${Routes.chatRooms}/:id',
      builder: (context, state) {
        String? roomId = state.pathParameters['id'];
        if (roomId == null) {
          return SizedBox.shrink();
        } else {
          return ChatCloud(
            viewModel: ChatCloudViewModel(
              chatId: roomId,
              authState: context.read<AuthState>(),
              chatState: context.read<ChatState>(),
              chatRepository: context.read<ChatRepository>(),
              userRepository: context.read<UserRepository>(),
            ),
          );
        }
      },
    ),
    GoRoute(
      path: Routes.chatRoomRobot,
      builder: (context, state) {
        return Consumer<ChatAiViewModel>(
          builder: (context, viewModel, child) =>
              ChatAiPage(viewModel: viewModel),
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      // 1. Change from 'builder' to 'pageBuilder'
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          // 2. Add a dynamic key tied to your user session.
          // When the user logs out, this key changes, destroying the entire layout state.
          // key: ValueKey(authState.userId ?? 'unauthenticated'),
          child: AppLayout(
            navigationShell: navigationShell,
            routeBottom: [
              NavigationConfig(
                icon: Icons.hub_outlined,
                selectedIcon: Icons.hub,
                label: NavigationConfigLabel.quiz,
              ),
              NavigationConfig(
                icon: Icons.people_outline,
                selectedIcon: Icons.people,
                label: NavigationConfigLabel.explore,
              ),
              NavigationConfig(
                icon: Icons.chat_bubble_outline,
                selectedIcon: Icons.chat_bubble,
                label: NavigationConfigLabel.mess,
              ),
              NavigationConfig(
                icon: Icons.settings,
                selectedIcon: Icons.storage,
                label: NavigationConfigLabel.me,
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.quizLanding,
              builder: (context, state) => QuizLandingScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.explore,
              builder: (context, state) => ExploreScreen(
                viewModel: ExploreViewModel(appNavBarState: context.read()),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.chatRooms,
              builder: (context, state) => ChatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.me,
              builder: (context, state) => MeScreen(
                viewModel: MeViewModel(
                  context.read(),
                  context.read(),
                  context.read(),
                  context.read(),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final bool isLoggedIn = context.read<AuthState>().isAuthenticated;
  final bool isLogin = state.matchedLocation == Routes.login;
  if (!isLoggedIn) {
    return Routes.login;
  }
  if (isLogin) {
    return Routes.home;
  }
  return null;
}
