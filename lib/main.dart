import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  Logger.root.level = Level.ALL;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    providerAndroid: AndroidDebugProvider(
      debugToken: '6A7E394A-FB4D-4FE7-9BC0-D00FFDEF5D70',
    ),
    providerApple: kDebugMode ? AppleDebugProvider() : AppleAppAttestProvider(),
    providerWeb: kDebugMode ? WebDebugProvider() : WebReCaptchaProvider(),
  );

  await dotenv.load();
  SharedPreferences pref = await SharedPreferences.getInstance();
  AppConfig.instance.load(pref);

  await MainApp.main(pref);
}
