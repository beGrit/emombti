import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/ui/chat/view_models/chats_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class ChatAddDialog extends StatefulWidget {
  const ChatAddDialog({required this.viewModel, super.key});

  final ChatsViewModel viewModel;

  static Future<String?> show(BuildContext context, ChatsViewModel viewModel) {
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (context) => ChatAddDialog(viewModel: viewModel),
    );
  }

  @override
  State<ChatAddDialog> createState() => _ChatAddDialogState();
}

class _ChatAddDialogState extends State<ChatAddDialog> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.viewModel.clearSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = widget.viewModel;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480, maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add Chat Room',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Search by name or email',
                    leading: const Icon(Icons.search),
                    trailing: _searchController.text.isNotEmpty
                        ? [
                            IconButton(
                              onPressed: () {
                                _searchController.clear();
                                viewModel.clearSearch();
                                setState(() {});
                              },
                              icon: const Icon(Icons.clear),
                            ),
                          ]
                        : null,
                    onChanged: (value) {
                      setState(() {});
                      viewModel.onSearchQueryChanged(value);
                    },
                    elevation: const WidgetStatePropertyAll<double>(0),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListenableBuilder(
                    listenable: viewModel.createChatRoomCommand,
                    builder: (context, _) {
                      return _SearchResultsList(
                        viewModel: viewModel,
                        isCreating: viewModel.createChatRoomCommand.running,
                        onUserSelected: (user) =>
                            _onUserSelected(context, user),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onUserSelected(BuildContext context, User user) async {
    await widget.viewModel.createChatRoomCommand.execute(user);

    if (!context.mounted) {
      return;
    }

    if (widget.viewModel.createChatRoomCommand.completed) {
      if (widget.viewModel.createChatRoomCommand.result is Ok) {
        Chat room = (widget.viewModel.createChatRoomCommand.result as Ok).value;
        widget.viewModel.clearSearch();
        Navigator.of(context).pop(room.id);
      }
    }
  }
}

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({
    required this.viewModel,
    required this.isCreating,
    required this.onUserSelected,
  });

  final ChatsViewModel viewModel;
  final bool isCreating;
  final ValueChanged<User> onUserSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (viewModel.isSearchingUsers || isCreating) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.searchError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Search failed. Please try again.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (viewModel.searchQuery.trim().isEmpty &&
        viewModel.searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Search for someone to start a chat',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (viewModel.searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'No users found',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: viewModel.searchResults.length,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 72),
      itemBuilder: (context, index) {
        final user = viewModel.searchResults[index];
        final displayName = user.name?.trim().isNotEmpty == true
            ? user.name!
            : 'Unknown User';

        return ListTile(
          enabled: !isCreating,
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              displayName.characters.first.toUpperCase(),
              style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
            ),
          ),
          title: Text(
            displayName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            user.email ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(Icons.chat_bubble_outline),
          onTap: () => onUserSelected(user),
        );
      },
    );
  }
}
