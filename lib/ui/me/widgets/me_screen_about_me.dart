import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MeScreenAboutMe extends StatelessWidget {
  const MeScreenAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
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
}
