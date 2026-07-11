import 'dart:math';

import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/feed/view_models/feed_post_detail_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_post_quill_viewer_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grit_soft_feed_social/grit_soft_feed_social.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPostDetail extends StatefulWidget {
  const FeedPostDetail({super.key, required this.viewModel});

  final FeedPostDetailViewmodel viewModel;

  @override
  State<FeedPostDetail> createState() => _FeedPostDetailState();
}

class _FeedPostDetailState extends State<FeedPostDetail> {
  late final ScrollController _scrollController;
  final GlobalKey _commentsKey = GlobalKey();
  bool _showComposer = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final RenderBox? renderBox =
        _commentsKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final position = renderBox.localToGlobal(Offset.zero);
    final double widgetTopOnScreen = position.dy;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isVisibleOnScreen = widgetTopOnScreen < screenHeight;
    if (isVisibleOnScreen && !_showComposer) {
      setState(() => _showComposer = true);
    } else if (!isVisibleOnScreen && _showComposer) {
      setState(() => _showComposer = false);
    }
  }

  void _onKeyboardHeightChanged(double height) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || !_scrollController.hasClients || height == 0) {
        return;
      }
      _scrollController.jumpTo(
        min(
          _scrollController.offset + height,
          _scrollController.position.maxScrollExtent,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainer,
      appBar: StandardAppBar(
        title: 'Post',
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          ListenableBuilder(
            listenable: widget.viewModel.loadPostCommand,
            builder: (context, _) {
              final post = widget.viewModel.post;
              if (post == null ||
                  post.author.id != widget.viewModel.currentUserId) {
                return const SizedBox.shrink();
              }
              return ListenableBuilder(
                listenable: widget.viewModel.deletePostCommand,
                builder: (context, _) {
                  final command = widget.viewModel.deletePostCommand;

                  if (command.completed) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        context.pop();
                      }
                    });
                  }

                  return IconButton(
                    onPressed: command.running
                        ? null
                        : () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Post'),
                                content: const Text(
                                  'Are you sure you want to delete this post? This action cannot be undone.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  FilledButton(
                                    onPressed: () => context.pop(true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );

                            if (confirmed == true && mounted) {
                              widget.viewModel.deletePostCommand.execute(
                                post.id!,
                              );
                            }
                          },
                    icon: command.running
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListenableBuilder(
            listenable: widget.viewModel.loadPostCommand,
            builder: (context, _) {
              final command = widget.viewModel.loadPostCommand;

              if (command.running) {
                return const Center(child: CircularProgressIndicator());
              }

              if (command.error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Failed to load post',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: command.execute,
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final post = widget.viewModel.post;
              if (post == null) {
                return Center(
                  child: Text(
                    'Post not found',
                    style: theme.textTheme.titleMedium,
                  ),
                );
              }

              return CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  DecoratedSliver(
                    decoration: BoxDecoration(color: theme.colorScheme.surface),
                    sliver: SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _AuthorSection(post: post),
                            const SizedBox(height: 16),
                            if (post.title != null &&
                                post.title!.isNotEmpty) ...[
                              Text(
                                post.title!,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                            if (post.body != null) ...[
                              _PostBody(body: post.body!),
                              const SizedBox(height: 16),
                            ],
                            if (post.photos.isNotEmpty) ...[
                              _PhotoGallery(post: post),
                              const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: 16)),

                  DecoratedSliver(
                    decoration: BoxDecoration(color: theme.colorScheme.surface),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        // SliverToBoxAdapter(
                        //   child: SocialActions(
                        //     displayType: ActionsDisplayType.horizontal,
                        //     actionsController:
                        //         widget.viewModel.actionsController,
                        //   ),
                        // ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Divider(),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(key: _commentsKey, height: 0),
                        ),
                        CommentAnimatedList(
                          asSliver: true,
                          commentController: widget.viewModel.commentController,
                        ),
                        ComposerHeight(
                          onKeyboardHeightChanged: _onKeyboardHeightChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          if (_showComposer)
            Positioned(
              left: 0,
              right: 0,
              top: null,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                opacity: _showComposer ? 1.0 : 0.0,
                child: Composer(),
              ),
            ),
        ],
      ),
    );
  }
}

class _AuthorSection extends StatelessWidget {
  const _AuthorSection({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage: post.author.avatar != null
              ? NetworkImage(post.author.avatar!.uri.toString())
              : null,
          child: post.author.avatar == null
              ? Text(
                  (post.author.name ?? '?').substring(0, 1).toUpperCase(),
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
                      style: theme.textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.tonal(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.tertiaryContainer,
                      foregroundColor: colorScheme.onTertiaryContainer,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: theme.textTheme.labelSmall,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text('Follow Up?'),
                    ),
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
          alignmentOffset: const Offset(-50, 5),
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
        ),
      ],
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    return FeedPostViewerBody(rawBody: body);
  }
}

class _PhotoGallery extends StatelessWidget {
  const _PhotoGallery({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imageUrls = post.photos.map((p) => p.uri.toString()).toList();
    final postUniqueId = post.id ?? post.created.toIso8601String();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: post.photos.asMap().entries.map((entry) {
        final index = entry.key;
        final photoUrl = entry.value.uri.toString();
        final heroTag = 'hero-$postUniqueId-$photoUrl';

        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
          child: GestureDetector(
            onTap: () {
              context.push(
                Routes.feedPhotoView,
                extra: {
                  'imageUrls': imageUrls,
                  'initialIndex': index,
                  'heroTag': heroTag,
                },
              );
            },
            child: Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  photoUrl,
                  // 1. 核心设置：宽度填满容器，高度根据图片真实宽高比自动等比缩放
                  fit: BoxFit.fitWidth,

                  loadingBuilder:
                      (
                        BuildContext context,
                        Widget child,
                        ImageChunkEvent? loadingProgress,
                      ) {
                        // 2. 图片加载完成后，直接返回 child (此时 child 已经是包含了原图宽高的 Widget)
                        if (loadingProgress == null) return child;

                        // 3. 图片未加载完时，给一个 16:9 的默认比例占位，防止高度为0导致页面闪烁
                        return AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            color: colorScheme.surfaceContainerLow,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                  errorBuilder: (context, error, stackTrace) => AspectRatio(
                    // 4. 错误状态下也给一个固定比例，保证 UI 整洁
                    aspectRatio: 16 / 9,
                    child: Container(
                      color: colorScheme.surfaceContainerHigh,
                      child: const Center(
                        child: Icon(Icons.broken_image_outlined, size: 48),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
