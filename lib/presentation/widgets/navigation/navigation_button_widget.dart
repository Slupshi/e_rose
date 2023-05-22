import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/navigation/navigation_base.dart';
import 'package:e_rose/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationButtonWidget extends StatelessWidget with NavigationBase {
  final MyRoute route;
  final bool isSelected;
  const NavigationButtonWidget({
    super.key,
    required this.route,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 5,
                  color: CustomColors.red,
                ),
              ),
            )
          : null,
      child: InkWell(
        hoverColor: CustomColors.lighterBlack,
        mouseCursor: SystemMouseCursors.click,
        onTap: () => context.go(route.path),
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        route.icon,
                        size: route.iconSize,
                        color: CustomColors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        route.name,
                        textScaleFactor: textScaleFactor(context),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
