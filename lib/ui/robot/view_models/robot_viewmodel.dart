import 'package:emombti/app_state/auth.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/foundation.dart';

class ChatBotViewModel extends ChangeNotifier {
  BotStatus _currentState = BotStatus.idle;
  BotStatus get currentState => _currentState;

  late final ChatSession? _chat;
  late final GenerativeModel? _model;

  late final AuthState authState;

  ChatBotViewModel({required this.authState}) {
    final generationConfig = GenerationConfig(thinkingConfig: null);
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.1-flash-lite',
      generationConfig: generationConfig,
    );
    _chat = _model?.startChat();
    analysisCommand = Command0<void>(_analyzeMbti);
  }

  late final Command0<void> analysisCommand;

  Future<Result<void>> _analyzeMbti() async {
    return Result.ok(null);
  }

  void switchToState(BotStatus newState) {
    if (_currentState == newState) return;
    _currentState = newState;
    notifyListeners();
  }
}
