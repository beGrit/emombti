import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/manager/app_state_manager.dart';
import 'package:emombti/manager/connectivity_manager.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:emombti/manager/sync_manager.dart';
import 'package:emombti/providers.dart';
import 'package:emombti/routing/router.dart';
import 'package:emombti/ui/core/ui/widgets/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/core/localization/app_localizations.dart';

class MainApp extends StatefulWidget {
  static Future<void> main(SharedPreferences pref) async {
    AppConfig appConfig = AppConfig.instance;

    ThemeState themeState = ThemeState(
      brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
    themeState.load(appConfig);

    var authState = AuthState();
    var storageManager = StorageManager(authState: authState);
    await storageManager.buildStorage();
    var repositoryManager = RepositoryManager();
    await repositoryManager.buildRepositories(storageManager);
    var connectivityManager = ConnectivityManager();
    await connectivityManager.load();
    var syncManager = SyncManager(cm: connectivityManager);

    var appStateManager = AppStateManager();
    await appStateManager.buildAppState(
      appConfig: appConfig,
      authState: authState,
      themeState: themeState,
      storageManager: storageManager,
      repositoryManager: repositoryManager,
      syncManager: syncManager,
    );

    runApp(
      MainAppProviders(
        storageManager: storageManager,
        repositoryManager: repositoryManager,
        appStateManager: appStateManager,
        connectivityManager: connectivityManager,
        syncManager: syncManager,
        child: const MainApp(),
      ),
    );
  }

  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  _MainAppState();
  late final GoRouter _routerConfig;

  @override
  void initState() {
    super.initState();
    _routerConfig = router(context.read<AppStateManager>().authState);
  }

  @override
  void dispose() {
    _routerConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeState, AppConfig>(
      builder: (context, themState, appConfig, child) {
        return MaterialApp.router(
          title: 'eMBTI',
          debugShowCheckedModeBanner: false,
          theme: themState.currentMaterialTheme.light(),
          darkTheme: themState.currentMaterialTheme.dark(),
          themeMode: appConfig.themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('zh')],
          routerConfig: _routerConfig,
          builder: (context, routerWidget) {
            return NotificationWrapper(
              connectivityManager: context.read<ConnectivityManager>(),
              child: routerWidget ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
