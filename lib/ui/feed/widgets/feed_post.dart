import 'package:emombti/app_state/feed.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../view_models/feed_post_viewmodel.dart';
import 'feed_post_quill_viewer_body_preview.dart';

class FeedPostScreen extends StatelessWidget {
  const FeedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FeedPostViewModel>();
    final theme = Theme.of(context);
    // Calculate the top offset to account for the floating TabBar header in ExploreScreen
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          const _FeedPostScreenHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<FeedPostViewModel>().loadPostsCommand.execute(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Consumer<FeedPostNotifier>(
                  builder: (context, feedPostNotifier, child) => ListenableBuilder(
                    listenable: Listenable.merge([
                      viewModel.loadPostsCommand,
                      viewModel.loadMorePostsCommand,
                    ]),
                    builder: (context, child) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          // 1. Ensure we only listen to the primary scroll view, not nested ones
                          if (scrollInfo.depth == 0) {
                            final metrics = scrollInfo.metrics;
                            if (metrics.pixels >=
                                    metrics.maxScrollExtent - 200 &&
                                !viewModel.loadMorePostsCommand.running &&
                                !viewModel.loadPostsCommand.running &&
                                feedPostNotifier.value.items.isNotEmpty &&
                                viewModel.hasMore) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (context.mounted) {
                                  viewModel.loadMorePostsCommand.execute();
                                }
                              });
                            }
                          }
                          return false; // Allows the notification to bubble up if needed
                        },
                        child: CustomScrollView(
                          key: const PageStorageKey('feed-post-page-view'),
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          slivers: [
                            if (viewModel.loadPostsCommand.running &&
                                feedPostNotifier.value.items.isEmpty)
                              const SliverFillRemaining(
                                child: Center(child: Text('Refreshing')),
                              )
                            else if (viewModel.loadPostsCommand.error)
                              const SliverFillRemaining(
                                child: Center(child: Text('Error')),
                              )
                            else if (feedPostNotifier.value.items.isEmpty)
                              const SliverFillRemaining(
                                child: Center(child: Text('No posts found')),
                              )
                            else
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    if (index <
                                        feedPostNotifier.value.items.length) {
                                      final post =
                                          feedPostNotifier.value.items[index];
                                      return _PostListTile(
                                        post: post,
                                        viewModel: viewModel,
                                      );
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 32.0,
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  },
                                  childCount:
                                      feedPostNotifier.value.items.length +
                                      (viewModel.hasMore ? 1 : 0),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        onPressed: () async {
          final newPost = await context.push<Post>(Routes.feedPostEditor);
          if (newPost != null && context.mounted) {
            viewModel.addPost(newPost);
          }
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class _FeedPostScreenHeader extends StatelessWidget {
  const _FeedPostScreenHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SizedBox(height: MediaQuery.of(context).padding.top + 56.0)],
    );
  }
}

class _PostListTile extends StatelessWidget {
  const _PostListTile({required this.post, required this.viewModel});

  final FeedPostViewModel viewModel;

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Author Info (Avatar | Name + Date)
              Row(
                children: [
                  CircleAvatar(
                    // Use author's avatar if available, otherwise display initial
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: post.author.avatar != null
                        ? NetworkImage(post.author.avatar!.uri.toString())
                        : null,
                    child: post.author.avatar == null
                        ? Text(
                            (post.author.name ?? '?')
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.author.name ?? 'Unknown User',
                                style: theme.textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            FilledButton.tonal(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.tertiaryContainer,
                                foregroundColor:
                                    colorScheme.onTertiaryContainer,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                ), // Strips left/right and top/bottom inner spaces
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: theme.textTheme.labelSmall,
                              ),
                              child: const Text('Follow Up?'),
                            ),
                          ],
                        ),
                        Text(
                          timeago.format(post.created),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MenuAnchor(
                    // 1. Set the anchor's alignment origin to the bottom-right of your button
                    alignmentOffset: const Offset(
                      -50,
                      5,
                    ), // 2. Shift it left to expand leftwards (adjust -120 based on your menu width)
                    builder: (context, controller, child) {
                      return IconButton.filledTonal(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(Icons.more_horiz),
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                        child: const Text('Like'),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                        child: const Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: Post content (Title, Body, Photos)
              GestureDetector(
                onTap: () {
                  context.push('${Routes.feedPost}/${post.id}');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (post.title != null && post.title!.isNotEmpty)
                      Text(
                        post.title ?? '',
                        style: theme.textTheme.titleMedium,
                      ),
                    if (post.body != null) ...[
                      const SizedBox(height: 4),
                      FeedPostViewerBodyPreview(
                        text: viewModel.paraseBody(post.body),
                        maxLines: 2,
                      ),
                    ],
                  ],
                ),
              ),

              if (post.photos.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: Row(
                    spacing: 8,
                    children: post.photos.take(2).toList().asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final photo = entry.value;
                      final photoUrl = photo.uri.toString();

                      final isLastVisible =
                          index == 1 && post.photos.length > 2;
                      final remainingCount = post.photos.length - 2;

                      // Using post.id or a unique fallback string
                      final postUniqueId =
                          post.id ?? post.created.toIso8601String();
                      final heroTag = 'hero-$postUniqueId-$photoUrl';

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(
                              Routes.feedPhotoView,
                              extra: {
                                'imageUrls': post.photos
                                    .map((p) => p.uri.toString())
                                    .toList(),
                                'initialIndex': index,
                                'heroTag':
                                    heroTag, // Passed directly to the destination route
                              },
                            );
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Hero(
                                tag: heroTag,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    photoUrl,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    loadingBuilder:
                                        (
                                          BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress,
                                        ) {
                                          if (loadingProgress == null) {
                                            return child; // Image is fully loaded, show it
                                          }

                                          return Center(
                                            child: CircularProgressIndicator(
                                              value:
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: colorScheme
                                                  .surfaceContainerHigh,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.broken_image_outlined,
                                                  size: 48,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                              if (isLastVisible)
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.tertiary
                                        .withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                      bottom: 8.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '+$remainingCount',
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                              color:
                                                  theme.colorScheme.onTertiary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                spacing: 2,
                children: [
                  FilledButton(
                    onPressed: () {
                      context.push('${Routes.feedPost}/${post.id}');
                    },
                    child: const Text('View post'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show related'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
