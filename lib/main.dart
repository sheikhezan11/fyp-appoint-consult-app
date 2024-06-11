import 'package:MedEase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:uuid/uuid.dart';

import 'resources/routes/pages.dart';
import 'resources/routes/routes.dart';
var uuid = const Uuid();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff68609c)),
          useMaterial3: true,
      ),
      title: 'MedEase',
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      initialRoute: Routes.onboardingView,
      // home:  const OnboardView(),
       getPages: Pages.appRoutes(),
    );
  }
}