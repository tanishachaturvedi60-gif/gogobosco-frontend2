import 'package:flutter/material.dart';
import 'package:gogobosco/core/theme.dart';
import 'routes.dart';

class GoGoBoscoApp extends StatelessWidget {
  const GoGoBoscoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRoutes.router,
    );
  }
}
