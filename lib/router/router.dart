import 'package:e_rose/presentation/views/accidents/web/accident_declaration_view.dart';
import 'package:e_rose/presentation/views/accidents/web/accident_map_view.dart';
import 'package:e_rose/presentation/views/accidents/web/accidents_list_view.dart';
import 'package:e_rose/presentation/views/auth/web/auth_view.dart';
import 'package:e_rose/presentation/views/heroes/web/profile_view.dart';
import 'package:e_rose/presentation/views/auth/web/register_view.dart';
import 'package:e_rose/presentation/views/heroes/web/heroes_list_view.dart';
import 'package:e_rose/presentation/views/home/web/home_view.dart';
import 'package:e_rose/presentation/widgets/navigation/web_navigation.dart';
import 'package:e_rose/router/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: Routes.homePage,
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
        // Get every top navigation bar routes
        for (var route in navigationRoutes) ...[
          GoRoute(
            path: route.path,
            pageBuilder: (context, state) => NoTransitionPage(
              child: route.child,
            ),
          ),
        ],
        // other routes
        GoRoute(
          path: Routes.homePage,
          pageBuilder: (context, state) => NoTransitionPage(
            child: _child(webChild: const HomeViewWeb()),
          ),
        ),
        GoRoute(
          path: Routes.authPage,
          pageBuilder: (context, state) => NoTransitionPage(
            child: _child(webChild: const AuthViewWeb()),
          ),
        ),
        GoRoute(
          path: Routes.profilePage,
          pageBuilder: (context, state) => NoTransitionPage(
            child: _child(webChild: const UserProfileViewWeb()),
          ),
        ),
        GoRoute(
          path: Routes.registerPage,
          pageBuilder: (context, state) => NoTransitionPage(
            child: _child(webChild: RegisterViewWeb()),
          ),
        ),
        GoRoute(
          path: Routes.accidentList,
          pageBuilder: (context, state) => NoTransitionPage(
            child: _child(webChild: const AccidentsListViewWeb()),
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

  /// ### Top Navigation bar routes
  const MyRoute({
    required this.name,
    required this.path,
    required this.icon,
    this.iconSize = 20,
    required this.child,
  });
}

final List<MyRoute> navigationRoutes = [
  MyRoute(
    name: "Heros",
    path: Routes.heroesListPage,
    icon: Icons.people_alt,
    child: _child(
      webChild: const HeroesListViewWeb(),
    ),
  ),
  MyRoute(
    name: "Incidents",
    path: Routes.hazardMapPage,
    icon: FontAwesomeIcons.mapLocationDot,
    child: _child(
      webChild: AccidentMapViewWeb(),
    ),
  ),
  MyRoute(
    name: "Déclaration",
    path: Routes.hazardDeclarationPage,
    icon: Icons.phone_in_talk_sharp,
    child: _child(
      webChild: AccidentDeclarationViewWeb(),
    ),
  ),
];

/// Get the current platform associated child
///
/// ### Currently working with web only
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
