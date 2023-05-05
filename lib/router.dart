import 'package:e_rose/presentation/views/heroes/web/hero_list_view.dart';
import 'package:e_rose/presentation/views/home/web/home_view.dart';
import 'package:e_rose/presentation/widgets/navigation/web_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: "/",
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        if (kIsWeb) {
          return WebNavigation(child: child);
        }
        // else if (defaultTargetPlatform == TargetPlatform.android) {
        //   return MobileNavigation(child: child);
        // } else if (defaultTargetPlatform == TargetPlatform.windows) {
        //   return DesktopNavigation(child: child);
        // }
        else {
          return const Scaffold(
            body: Center(
              child: Text("Not Implemented"),
            ),
          );
        }
      },
      routes: <GoRoute>[
        for (var route in routes)
          GoRoute(
            path: route.path,
            pageBuilder: (context, state) => NoTransitionPage(
              child: route.child,
            ),
          ),
      ],
    ),
  ],
);

class MyRoute {
  final String name;
  final String path;

  final IconData icon;
  final double iconSize;

  final Widget child;

  const MyRoute({
    required this.name,
    required this.path,
    required this.icon,
    this.iconSize = 20,
    required this.child,
  });
}

final List<MyRoute> routes = [
  MyRoute(
    name: "Home",
    path: "/",
    icon: Icons.home,
    child: _child(
      // mobileChild: const HomeViewMobile(),
      // desktopChild: const HomeViewDesktop(),
      webChild: const HomeViewWeb(),
    ),
  ),
  MyRoute(
    name: "HeroList",
    path: "/heroes",
    icon: Icons.people_alt,
    child: _child(
      webChild: const HeroListViewWeb(),
    ),
  ),
];

Widget _child({
  //required Widget mobileChild,
  //required Widget desktopChild,
  required Widget webChild,
}) {
  if (kIsWeb) {
    return webChild;
  }
  // else if (Platform.isAndroid || Platform.isIOS) {
  //   return mobileChild;
  // } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
  //   return Expanded(child: desktopChild);
  // }
  else {
    return const Expanded(
      child: Center(
        child: Text("Not Implemented"),
      ),
    );
  }
}
