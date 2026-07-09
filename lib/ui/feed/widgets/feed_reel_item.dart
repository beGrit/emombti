import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:grit_soft_feed_reel/core/builders.dart';
import 'package:grit_soft_feed_reel/core/models.dart';
import 'package:grit_soft_feed_reel/ui/reel.dart';
import 'package:grit_soft_feed_reel/ui/reel_actions.dart';
import 'package:provider/provider.dart';

class FeedReelItem extends StatefulWidget {
  final ReelInfo reelInfo;

  const FeedReelItem({super.key, required this.reelInfo});

  @override
  State<FeedReelItem> createState() => _FeedReelItemState();
}

class _FeedReelItemState extends State<FeedReelItem> {
  late final FeedReelViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<FeedReelViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Reel(
      reelInfo: widget.reelInfo,
      builders: Builders(
        infoBuilderlandscape: (context) => Text(
          widget.reelInfo.title ?? 'Title',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black.withValues(alpha: 0.5),
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        actionBuilderlandscape: (context) => ReelActionsLandscape(),
        infoBuilderPortrait: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.reelInfo.title ?? 'Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black.withValues(alpha: 0.5),
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.reelInfo.titleSub != null)
              Row(
                children: [
                  Text(
                    widget.reelInfo.titleSub ?? '',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
          ],
        ),
        actionBuilderPortrait: (context) => ReelActionsPortrait(),
      ),
    );
  }
}
