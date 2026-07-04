import 'package:cached_network_image/cached_network_image.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_models/me_screen_viewmodel.dart';
import 'me_screen_avatar.dart';

class MeScreen extends StatefulWidget {
  final MeViewModel viewModel;

  const MeScreen({
    super.key,
    this.showBackButton = false,
    required this.viewModel,
  });

  final bool showBackButton;

  @override
  State<StatefulWidget> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final double headerHeight = MediaQuery.of(context).size.height < 400
        ? 280
        : 250;
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final user = widget.viewModel.user;
        return Scaffold(
          body: DefaultTabController(
            length: 3,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: headerHeight,
                  stretch: true,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: theme.colorScheme.primary,
                  leading: widget.showBackButton ? const BackButton() : null,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        color: colorScheme.surfaceBright,
                      ),
                      onPressed: () => _openScanner(context),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => context.push(Routes.settings),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: LayoutBuilder(
                      builder: (context, constraints) {
                        final double minExtent =
                            MediaQuery.of(context).padding.top + kToolbarHeight;
                        final double currentHeight = constraints.maxHeight;
                        final double delta =
                            (currentHeight - minExtent) /
                            (headerHeight - minExtent);
                        final double opacity = delta.clamp(0.0, 1.0);

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                context.push(Routes.meBackground);
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  user?.backgroundImg != null
                                      ? CachedNetworkImage(
                                          imageUrl: user!.backgroundImg!.uri
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Container(
                                          color: theme
                                              .colorScheme
                                              .surfaceContainer,
                                        ),
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.3),
                                  ),
                                ],
                              ),
                            ),
                            Opacity(
                              opacity: opacity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: kToolbarHeight),
                                    MeScreenAvatar(viewModel: widget.viewModel),
                                    const SizedBox(height: 12),
                                    Text(
                                      user?.name ?? "Unknown Name",
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .surfaceContainer,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    if (user != null) ...[
                                      const SizedBox(height: 4),
                                      if (user.email != null &&
                                          user.email!.isNotEmpty)
                                        Text(
                                          user.email ?? '',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .surfaceContainer
                                                    .withValues(alpha: 0.8),
                                              ),
                                        ),
                                    ],
                                    const SizedBox(height: 8),
                                    if (user != null &&
                                        user.mbtiType != null &&
                                        user.mbtiType != '')
                                      Chip(
                                        label: Text(
                                          user.mbtiType ?? '',
                                          style: theme.textTheme.labelMedium
                                              ?.copyWith(
                                                color:
                                                    theme.colorScheme.tertiary,
                                              ),
                                        ),
                                        backgroundColor:
                                            theme.colorScheme.tertiaryContainer,
                                        side: BorderSide.none,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            if (opacity < 0.2)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: kToolbarHeight / 2,
                                  ),
                                  child: Text(
                                    user?.name ?? "MBTI Explorer",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                if (user == null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 80,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Login to view your profile",
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 24),
                          FilledButton(
                            onPressed: () => context.push(Routes.login),
                            child: const Text("Go to Login"),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      child: Container(
                        color: colorScheme.surface,
                        child: TabBar(
                          controller: _tabController,
                          labelColor: colorScheme.primary,
                          unselectedLabelColor: colorScheme.onSurfaceVariant,
                          indicatorColor: colorScheme.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: const [
                            Tab(text: "My Activity"),
                            Tab(text: "History"),
                            Tab(text: "About Me"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: _tabController,
                    builder: (context, child) {
                      switch (_tabController.index) {
                        case 0:
                          return _buildMyActivityTab(
                            context,
                            theme,
                            widget.viewModel,
                          );
                        case 1:
                          return _buildHistoryTab(
                            context,
                            theme,
                            widget.viewModel,
                          );
                        case 2:
                          return _buildAboutMeTab(
                            context,
                            theme,
                            widget.viewModel,
                          );
                        default:
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyActivityTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 4.0),
            child: SegmentedButton<String>(
              segments: const <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'Posts',
                  label: Text('Posts'),
                  icon: Icon(Icons.article_outlined, size: 18),
                ),
                ButtonSegment<String>(
                  value: 'Videos',
                  label: Text('Videos'),
                  icon: Icon(Icons.videocam_outlined, size: 18),
                ),
                ButtonSegment<String>(
                  value: 'Popular',
                  label: Text('Popular'),
                  icon: Icon(Icons.local_fire_department_outlined, size: 18),
                ),
              ],
              selected: const {'Posts'},
              onSelectionChanged: (Set<String> newSelection) {},
              style: SegmentedButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        color: theme.colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.article_outlined,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Activity Post #$index",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: 0),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.tertiaryContainer,
              child: Icon(
                Icons.analytics_outlined,
                color: theme.colorScheme.tertiary,
                size: 20,
              ),
            ),
            title: Text("MBTI Test Round ${8 - index}"),
            subtitle: Text("Completed on 2026-05-${15 - index}"),
            trailing: const Icon(Icons.chevron_right, size: 18),
            onTap: () {},
          );
        }, childCount: 0),
      ),
    );
  }

  Widget _buildAboutMeTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 8),
        _buildListTile(
          Icons.person_outline,
          "Account Info",
          () => context.push(Routes.userInfo),
        ),
        _buildListTile(Icons.star_outline, "Saved & Favoriates", () {}),
        _buildListTile(
          Icons.social_distance,
          'Social: Comments & Likes',
          () {},
        ),
        _buildListTile(
          Icons.help_outline,
          "Help & Feedback",
          () => context.push(Routes.feedback),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        const SizedBox(height: 50),
      ]),
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  void _openScanner(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final String? result = await context.push<String>(Routes.qRCodeScanner);
    if (result != null && result.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Qr Scanner Result: $result'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child});

  final Container child;

  @override
  double get minExtent => 48.0;
  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
