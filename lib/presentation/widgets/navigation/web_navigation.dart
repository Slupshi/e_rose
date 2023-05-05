import 'package:e_rose/presentation/widgets/navigation/navigation_base.dart';
import 'package:e_rose/router.dart';
import 'package:flutter/material.dart';

class WebNavigation extends StatefulWidget {
  final Widget child;
  const WebNavigation({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _WebNavigationState();
}

class _WebNavigationState extends State<WebNavigation> with NavigationBase {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: InkWell(
          onTap: () => onItemTapped(context,
              routes.indexOf(routes.firstWhere((route) => route.path == "/"))),
          mouseCursor: SystemMouseCursors.click,
          child: const Center(
            child: Text(
              "E-Rose",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                size: 25,
              ),
            ),
          ),
        ],
        title: Row(
          children: [
            for (var route in routes) ...[
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                onTap: () => onItemTapped(context, routes.indexOf(route)),
                child: Container(
                  height: 50,
                  width: 200,
                  color: isCurrentRoute(context, route)
                      ? Colors.red
                      : Colors.transparent,
                  child: Center(child: Text(route.name)),
                ),
              ),
            ],
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
