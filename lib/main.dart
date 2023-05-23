import 'package:e_rose/presentation/common/theme.dart';
import 'package:e_rose/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appTitle = "E-Rose";

void main() {
  SharedPreferences.getInstance().then((prefs) => prefs.remove("token"));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      theme: AppTheme.themeDark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
