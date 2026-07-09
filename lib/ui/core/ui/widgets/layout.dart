import 'package:emombti/routing/navigation_config.dart';
import 'package:emombti/ui/core/ui/widgets/layout_app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    required this.navigationShell,
    required this.routeBottom,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavigationConfig> routeBottom;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final orientation = MediaQuery.of(context).orientation;
    final bool isLandscape = orientation == Orientation.landscape;
    final bool isDesktop = size.width >= 600 && size.height >= 600;
    final bool isExtended = size.width >= 1000;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    if (!isDesktop && isLandscape) {
      return Scaffold(body: navigationShell);
    }

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(child: navigationShell),
            if (isDesktop)
              NavigationRail(
                backgroundColor: colorScheme.surfaceContainer,
                extended: isExtended,
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (index) =>
                    navigationShell.goBranch(index),
                leading: isExtended
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "eMBTI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: FlutterLogo(),
                      ),
                destinations: [
                  for (final route in routeBottom)
                    NavigationRailDestination(
                      icon: route.badgeLabel != null
                          ? Badge(
                              label: route.badgeLabel!.isEmpty
                                  ? null
                                  : Text(route.badgeLabel!),
                              child: Icon(route.icon),
                            )
                          : Icon(route.icon),
                      selectedIcon: route.badgeLabel != null
                          ? Badge(
                              label: route.badgeLabel!.isEmpty
                                  ? null
                                  : Text(route.badgeLabel!),
                              child: Icon(route.selectedIcon),
                            )
                          : Icon(route.selectedIcon),
                      label: Text(route.label.label),
                    ),
                ],
              ),
            // This is the main content area
          ],
        ),
      );
    } else {
      return Scaffold(
        body: navigationShell,
        // Only show bottom nav on mobile
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorShape: null,
            iconTheme: WidgetStateProperty.all(const IconThemeData(size: 24)),
            labelTextStyle: WidgetStateProperty.all(
              textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            labelPadding: EdgeInsets.zero,
          ),
          child: AppLayoutNavigationBar(
            navigationShell: navigationShell,
            routeBottom: routeBottom,
          ),
        ),
      );
    }
  }
}
