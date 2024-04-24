import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:souschef/views/app_routes.dart';
import 'package:souschef/views/pages/home/home_page.dart';
import 'package:souschef/views/pages/recipe/add_recipe_page.dart';
import 'package:souschef/views/pages/recipe/recipe_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sous Chef',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E1E1E),
          background: const Color(0xFF202832),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.HOME,
      getPages: [
        GetPage(name: Routes.HOME, page: () => HomePage()),
        GetPage(name: Routes.RECIPE, page: () => RecipePage()),
        GetPage(name: Routes.ADD_RECIPE, page: () => AddRecipePage()),
      ],
    );
  }
}
