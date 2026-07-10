import 'package:flutter/material.dart';

class MeScreenHistory extends StatelessWidget {
  const MeScreenHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
}
