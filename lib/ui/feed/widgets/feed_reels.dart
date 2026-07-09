import 'package:emombti/ui/feed/models/feed_reel_model.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_reel_item.dart';
import 'package:flutter/material.dart';
import 'package:grit_soft_feed_reel/core/models.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

/// Vertical, full-viewport paging feed of videos (TikTok / Instagram Reels style).
class FeedReels extends StatefulWidget {
  final TabController tabController;
  final int tabIndex;

  const FeedReels({
    super.key,
    required this.tabController,
    required this.tabIndex,
  });

  @override
  State<FeedReels> createState() => _FeedReelsState();
}

class _FeedReelsState extends State<FeedReels> {
  late final PageController _pageController;

  bool isPause = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    isPause = false;
    widget.tabController.animation?.addListener(_onTabAnimation);
  }

  @override
  void dispose() {
    widget.tabController.animation?.removeListener(_onTabAnimation);
    _pageController.dispose();
    super.dispose();
  }

  void _onTabAnimation() {
    final animation = widget.tabController.animation;
    if (animation == null) return;
    final shouldPlay = animation.value == widget.tabIndex;
    if (shouldPlay && isPause) {
      setState(() {
        isPause = false;
      });
    } else if (!shouldPlay && !isPause) {
      setState(() {
        isPause = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedReelViewModel>(
      builder: (context, viewModel, child) {
        FeedReelModel model = viewModel.model;
        return ListenableBuilder(
          listenable: model,
          builder: (context, _) {
            if (model.items.isEmpty) {
              return const Center(child: Text('No videos'));
            } else {
              return PageView.custom(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                allowImplicitScrolling: false,
                onPageChanged: viewModel.onPageChanged,
                key: const PageStorageKey('feed-reel-page-view'),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = model.items[index];
                    return FeedReelItem(
                      reelInfo: ReelInfo(
                        id: item.id ?? Uuid().v4(),
                        videoUrl: item.videoUrl.uri.toString(),
                      ),
                    );
                  },
                  childCount: model.items.length,
                  addAutomaticKeepAlives: false,
                  addRepaintBoundaries: true,
                ),
              );
            }
          },
        );
      },
    );
  }
}
