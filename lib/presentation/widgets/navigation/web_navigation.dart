import 'package:e_rose/main.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/navigation/navigation_base.dart';
import 'package:e_rose/presentation/widgets/navigation/navigation_button_widget.dart';
import 'package:e_rose/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          onTap: () => context.go("/"),
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
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final token = prefs.getString("token");
                if (token == null || token == "") {
                  if (context.mounted) {
                    context.go("/auth");
                  }
                  return;
                }
                if (context.mounted) {
                  context.go("/profile");
                }
              },
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
              for (var route in navigationRoutes) ...[
                NavigationButtonWidget(
                  isSelected: isCurrentRoute(context, route),
                  route: route,
                ),
              ],
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
}
