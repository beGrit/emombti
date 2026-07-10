import 'package:cached_network_image/cached_network_image.dart';
import 'package:emombti/domain/models/activity/activity.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/me/view_models/me_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MeScreenActivityList extends StatefulWidget {
  final MeScreenViewModel viewModel;
  const MeScreenActivityList({super.key, required this.viewModel});

  @override
  State<MeScreenActivityList> createState() => _MeScreenActivityListState();
}

class _MeScreenActivityListState extends State<MeScreenActivityList> {
  String _selectedTab = 'Posts';

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadActivity.execute();
  }

  List<Activity> get _filteredActivities {
    final activities = widget.viewModel.activities;
    switch (_selectedTab) {
      case 'Videos':
        return activities
            .where((activity) => activity.type == ActivityType.video)
            .toList();
      case 'Popular':
        return activities
            .where((activity) => activity.type == ActivityType.popular)
            .toList();
      case 'Posts':
      default:
        return activities
            .where((activity) => activity.type == ActivityType.post)
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.viewModel,
        widget.viewModel.loadActivity,
      ]),
      builder: (context, _) {
        final activities = _filteredActivities;
        final isLoading =
            widget.viewModel.loadActivity.running &&
            widget.viewModel.activities.isEmpty;
        final hasError =
            widget.viewModel.loadActivity.error &&
            widget.viewModel.activities.isEmpty;

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
                      icon: Icon(
                        Icons.local_fire_department_outlined,
                        size: 18,
                      ),
                    ),
                  ],
                  selected: {_selectedTab},
                  onSelectionChanged: (Set<String> newSelection) {
                    if (newSelection.isEmpty) return;
                    setState(() {
                      _selectedTab = newSelection.first;
                    });
                  },
                  style: SegmentedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            ),
            if (isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (hasError)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: theme.colorScheme.error,
                          size: 36,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Failed to load activities.',
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (activities.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'No $_selectedTab activity yet.',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            else
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
                    final activity = activities[index];
                    return InkWell(
                      onTap: () => _onActivityTap(context, activity),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _ActivityThumbnail(
                                    activity: activity,
                                    theme: theme,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity.title ?? 'Untitled',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      if (activity.description != null &&
                                          activity.description!.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          activity.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                      const SizedBox(height: 6),
                                      Text(
                                        _formatDate(activity.createdAt),
                                        style: theme.textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                ),
                                onPressed: () {
                                  widget.viewModel.deleteActivityCommand
                                      .execute(activity.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: activities.length),
                ),
              ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }

  void _onActivityTap(BuildContext context, Activity activity) {
    if (activity.relatedId == null || activity.relatedId!.isEmpty) return;

    switch (activity.type) {
      case ActivityType.post:
        context.push('${Routes.feedPost}/${activity.relatedId}');
        break;
      case ActivityType.video:
        // No action, will develop later.
        break;
      case ActivityType.popular:
        break;
    }
  }
}

class _ActivityThumbnail extends StatelessWidget {
  const _ActivityThumbnail({required this.activity, required this.theme});

  final Activity activity;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (activity.thumbnailUrl != null && activity.thumbnailUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: activity.thumbnailUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            _FallbackThumbnail(activity: activity, theme: theme),
      );
    }

    return _FallbackThumbnail(activity: activity, theme: theme);
  }
}

class _FallbackThumbnail extends StatelessWidget {
  const _FallbackThumbnail({required this.activity, required this.theme});

  final Activity activity;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      child: Center(
        child: Icon(
          _iconForActivity(activity.type),
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  IconData _iconForActivity(ActivityType type) {
    switch (type) {
      case ActivityType.video:
        return Icons.videocam_outlined;
      case ActivityType.popular:
        return Icons.local_fire_department_outlined;
      case ActivityType.post:
        return Icons.article_outlined;
    }
  }
}
