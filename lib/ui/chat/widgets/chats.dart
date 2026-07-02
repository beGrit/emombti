import 'package:cached_network_image/cached_network_image.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/chats_viewmodel.dart';
import 'chats_add.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatsViewModel>(
      create: (context) => ChatsViewModel(
        authState: context.read(),
        chatRepository: context.read(),
        userRepository: context.read(),
        chatState: context.read(),
      )..loadRoomsCommand.execute(),
      builder: (context, _) {
        return Scaffold(
          appBar: StandardAppBar(
            title: 'Messages',
            actions: [
              IconButton(
                icon: const Icon(Icons.add_comment_outlined),
                tooltip: 'Add Chat Room',
                onPressed: () async {
                  String? roomIdVal = await ChatAddDialog.show(
                    context,
                    context.read<ChatsViewModel>(),
                  );
                  if (context.mounted) {
                    if (roomIdVal != null) {
                      await context.push('${Routes.chatRooms}/$roomIdVal');
                    }
                  }
                },
              ),
            ],
          ),
          body: Consumer2<ChatsViewModel, ChatState>(
            builder: (context, viewModel, chatState, _) {
              return RefreshIndicator(
                onRefresh: () => viewModel.loadRoomsCommand.execute(),
                child: ListenableBuilder(
                  listenable: viewModel.loadRoomsCommand,
                  builder: (context, _) {
                    final rooms = chatState.chats;
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        if (viewModel.loadRoomsCommand.running)
                          const SliverFillRemaining(
                            child: Center(child: Text('Loading')),
                          )
                        else if (viewModel.loadRoomsCommand.error)
                          const SliverFillRemaining(
                            child: Center(child: Text('Error')),
                          )
                        else if (rooms.isEmpty)
                          const SliverFillRemaining(
                            child: Center(child: Text('No active chats found')),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final room = rooms[index];
                              return _RoomListTile(room: room);
                            }, childCount: rooms.length),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({required this.room});

  final Chat room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatState = context.watch<ChatState>();
    final unreadCount = chatState.getUnreadCount(room.id);

    return Dismissible(
      key: ValueKey(room.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: theme.colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: Icon(Icons.delete_outline, color: theme.colorScheme.onError),
      ),
      onDismissed: (_) {
        context.read<ChatsViewModel>().deleteRoomCommand.execute(room.id);
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: CachedNetworkImage(
                imageUrl: room.image ?? '',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                // What to show while loading
                placeholder: (context, url) => Container(
                  color: theme.colorScheme.primaryContainer,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.group,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
            title: Text(
              room.name ?? 'Chat Room',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              room.lastMessage ?? 'Start a conversation...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${room.updated.hour}:${room.updated.minute.toString().padLeft(2, '0')}',
                  style: theme.textTheme.bodySmall,
                ),
                if (unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Badge(
                    label: Text(unreadCount.toString()),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                ],
              ],
            ),
            onTap: () async {
              await context.push('${Routes.chatRooms}/${room.id}');
            },
          ),
          const Divider(height: 1, indent: 80),
        ],
      ),
    );
  }
}
