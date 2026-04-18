import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routing/app_router.dart';

class BlackmoonApp extends StatelessWidget {
  const BlackmoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BLACKMOON Studio',
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
