import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

import '../view_models/me_screen_viewmodel.dart';

class MeScreenAvatar extends StatelessWidget {
  const MeScreenAvatar({super.key, required this.viewModel});

  final MeViewModel viewModel;

  Future<void> _onAvatarTap(BuildContext context) async {
    await viewModel.pickAndUploadAvatarCommand.execute();
    if (context.mounted) {
      if (viewModel.pickAndUploadAvatarCommand.result is Error) {
        // We only show snackbar if it's a real error (not just user cancelling)
        final errorStr = viewModel.pickAndUploadAvatarCommand.result.toString();
        if (!errorStr.contains('No image selected')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update avatar: $errorStr')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar updated successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = viewModel.user;
    final userName = user?.name ?? "MBTI Explorer";

    return ListenableBuilder(
      listenable: viewModel.pickAndUploadAvatarCommand,
      builder: (context, child) => GestureDetector(
        onTap: () => viewModel.pickAndUploadAvatarCommand.running
            ? null
            : _onAvatarTap(context),
        child: Stack(
          children: [
            CircleAvatar(
              radius: 46,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                child: viewModel.pickAndUploadAvatarCommand.running
                    ? const CircularProgressIndicator()
                    : user != null && user.avatar != null
                    ? Image.network(
                        user.avatar!.uri.toString(),
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildInitialsFallback(theme, userName),
                      )
                    : _buildInitialsFallback(theme, userName),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsFallback(ThemeData theme, String userName) {
    return Center(
      child: Text(
        userName.isNotEmpty ? userName[0] : "",
        style: theme.textTheme.headlineMedium,
      ),
    );
  }
}
