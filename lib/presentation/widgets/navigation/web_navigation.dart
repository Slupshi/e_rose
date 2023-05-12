import 'package:e_rose/main.dart';
import 'package:e_rose/presentation/common/colors.dart';
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
        backgroundColor: CustomColors.black,
        leadingWidth: 200,
        leading: InkWell(
          onTap: () => onItemTapped(context,
              routes.indexOf(routes.firstWhere((route) => route.path == "/"))),
          mouseCursor: SystemMouseCursors.click,
          child: const Center(
            child: Text(
              appTitle,
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
        title: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var route in routes)
                //
                _navButton(route),
            ],
          ),
        ),
      ),
      body: Material(
        color: CustomColors.nightBlue,
        child: widget.child,
      ),
    );
  }

  Widget _navButton(MyRoute route) {
    if (route.path == "/") return const SizedBox();
    return InkWell(
      hoverColor: CustomColors.lighterBlack,
      mouseCursor: SystemMouseCursors.click,
      onTap: () => onItemTapped(context, routes.indexOf(route)),
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    route.icon,
                    size: route.iconSize,
                    color: CustomColors.white,
                  ),
                  const SizedBox(width: 5),
                  Text(route.name),
                ],
              ),
            ),
            if (isCurrentRoute(context, route))
              const SizedBox(
                height: 5,
                width: 200,
                child: Material(
                  color: CustomColors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
