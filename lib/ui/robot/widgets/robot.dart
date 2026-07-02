import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/policy.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../view_models/robot_viewmodel.dart';

class ChatBot extends StatefulWidget {
  final ChatBotViewModel viewModel;

  const ChatBot({super.key, required this.viewModel});

  @override
  State<ChatBot> createState() => ChatBotState();
}

class ChatBotState extends State<ChatBot> with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  Future<bool?> _showAiPolicyDialog() async {
    final contentRepository = context.read<ContentRepository>();
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: PolicyNativeView(
                      policyType: 'policy_ai',
                      contentRepository: contentRepository,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Agree & Continue'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.viewModel.currentState == BotStatus.clicked) {
        widget.viewModel.switchToState(BotStatus.idle);
      }
    });

    widget.viewModel.addListener(_handleStateChange);
  }

  @override
  void dispose() {
    widget.viewModel.removeListener(_handleStateChange);
    _lottieController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChatBot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.viewModel != oldWidget.viewModel) {
      oldWidget.viewModel.removeListener(_handleStateChange);
      widget.viewModel.addListener(_handleStateChange);
    }
  }

  void _handleStateChange() {
    if (!mounted) return;
    switch (widget.viewModel.currentState) {
      case BotStatus.idle:
        _lottieController.repeat(min: 0, max: 0);
        break;
      case BotStatus.thinking:
        _lottieController.repeat(min: 0.3, max: 0.6);
        break;
      case BotStatus.speaking:
        _lottieController.repeat(min: 0.6, max: 0.8);
        break;
      case BotStatus.clicked:
        _lottieController.forward(from: 0.8);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () =>
                      widget.viewModel.switchToState(BotStatus.clicked),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Lottie.asset(
                      'assets/json/chatbot_v2.json',
                      fit: BoxFit.contain,
                      controller: _lottieController,
                      onLoaded: (composition) {
                        _lottieController.duration = composition.duration;
                        // Initialize the idle animation once the composition is loaded
                        _handleStateChange();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.viewModel.currentState == BotStatus.thinking
                      ? 'Thinking...'
                      : widget.viewModel.currentState == BotStatus.speaking
                      ? 'Speaking...'
                      : widget.viewModel.currentState == BotStatus.clicked
                      ? 'Ouch!'
                      : 'Active',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.2,
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Analyze MBTI'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            letterSpacing: -0.2,
                          ),
                        ),
                        onPressed: () async {
                          final agreed = await _showAiPolicyDialog();
                          if (!context.mounted) return;
                          if (agreed == true) {
                            context.push(Routes.chatRoomRobot);
                          }
                        },
                        child: const Text('Chat with AI Expert'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
