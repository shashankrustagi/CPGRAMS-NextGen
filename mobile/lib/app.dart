import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'config/theme.dart';

class CPGRAMSApp extends StatelessWidget {
  const CPGRAMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CPGRAMS NextGen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
