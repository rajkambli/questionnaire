import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire/app/core/theme/app_theme.dart';
import 'package:questionnaire/app/data/services/local_storage_service.dart';
import 'package:questionnaire/app/routes/app_pages.dart';
import 'package:questionnaire/app/routes/app_routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Questionnaire',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: LocalStorageService.isLoggedIn() ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
