import 'package:e_rose/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationBase {
  int currentIndex(BuildContext context) =>
      _locationToIndex(GoRouter.of(context).location);

  int _locationToIndex(String location) {
    final index = navigationRoutes.indexWhere((t) => location == t.path);
    // if index not found (-1), return 0
    return index;
  }

  bool isCurrentRoute(BuildContext context, MyRoute route) =>
      currentIndex(context) == navigationRoutes.indexOf(route);

  // callback used to navigate to the desired tab
  void onItemTapped(BuildContext context, int index) {
    if (index != currentIndex(context)) {
      context.go(navigationRoutes[index].path);
    }
  }
}
