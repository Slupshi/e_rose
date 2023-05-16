import 'package:e_rose/presentation/widgets/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccidentDeclarationViewWeb extends ConsumerWidget {
  const AccidentDeclarationViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const PageTemplateWidget(
      child: Column(
        children: [
          Row(
            children: [
              Center(child: Text("Declaration")),
            ],
          ),
        ],
      ),
    );
  }
}
