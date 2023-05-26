import 'package:e_rose/presentation/widgets/auth/login_widget.dart';
import 'package:e_rose/presentation/widgets/auth/register_widget.dart';
import 'package:e_rose/presentation/widgets/common/vertical_divider.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:flutter/material.dart';

class AuthViewWeb extends StatelessWidget {
  const AuthViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplateWidget(
      child: Row(
        children: [
          Expanded(child: LoginWidget()),
          const CustomVerticalDivider(),
          const Expanded(child: RegisterWidget()),
        ],
      ),
    );
  }
}
