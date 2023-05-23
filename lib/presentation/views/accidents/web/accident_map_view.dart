import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccidentMapViewWeb extends ConsumerWidget {
  const AccidentMapViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplateWidget(
      horizontalPaddingMultiplier: 20,
      verticalPaddingMultiplier: 20,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: FlutterMap(
          options: MapOptions(
            zoom: 5,
            onTap: (tapPosition, point) async {
              //await registerController.selectMapPoint(point);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
          ],
        ),
      ),
    );
  }
}
