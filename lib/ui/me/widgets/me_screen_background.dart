import 'package:cached_network_image/cached_network_image.dart';
import 'package:emombti/ui/me/view_models/me_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class MeBackgroundPicker extends StatefulWidget {
  final MeViewModel viewModel;
  const MeBackgroundPicker({super.key, required this.viewModel});

  @override
  State<MeBackgroundPicker> createState() => MeBackgroundPickerState();
}

class MeBackgroundPickerState extends State<MeBackgroundPicker> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.pickAndUploadAvatarCommand.addListener(
      _onPickAndUploadAvatarCommandChanged,
    );
  }

  void _onPickAndUploadAvatarCommandChanged() {
    if (mounted) {
      final messenger = ScaffoldMessenger.of(context);
      if (widget.viewModel.pickAndUploadAvatarCommand.error) {
        messenger.clearSnackBars();
        messenger.hideCurrentMaterialBanner();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Error uploading background image...'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      if (widget.viewModel.pickAndUploadAvatarCommand.completed) {
        messenger.clearSnackBars();
        messenger.hideCurrentMaterialBanner();
        messenger.showSnackBar(
          SnackBar(
            content: Text('Background image updated successfully!'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CloseButton(color: theme.colorScheme.onSurface),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.pickAndUploadAvatarCommand,
        builder: (context, child) {
          if (widget.viewModel.pickAndUploadAvatarCommand.running) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                width: MediaQuery.sizeOf(context).width,
                child: ClipRect(
                  // Keeps the zoomed image confined strictly to this 280-height box
                  child: InteractiveViewer(
                    clipBehavior: Clip.none,
                    maxScale: 4.0,
                    child: widget.viewModel.user?.backgroundImg != null
                        ? CachedNetworkImage(
                            imageUrl: widget.viewModel.user!.backgroundImg!.uri
                                .toString(),
                            fit: BoxFit.cover,
                            width: double
                                .infinity, // Fills the constraints of the parent SizedBox
                            height: double
                                .infinity, // Fills the constraints of the parent SizedBox
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Container(color: theme.colorScheme.surfaceContainer),
                  ),
                ),
              ),
              FilledButton(
                onPressed: () {
                  widget.viewModel.pickAndUploadAvatarCommand.execute();
                },
                child: const Text('Set as Background'),
              ),
            ],
          );
        },
      ),
    );
  }
}
