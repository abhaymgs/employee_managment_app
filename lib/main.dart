import 'dart:async';

import 'package:employee_managment_app/pages/home_page.dart';
import 'package:employee_managment_app/res/theme/theme.dart';
import 'package:employee_managment_app/res/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() {
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
        child: const MyApp(),
      ),
    );
  }, (error, errorStack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Employee Managment',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.currentTheme,
          home: const HomePage(),
        );
      },
    );
  }
}
