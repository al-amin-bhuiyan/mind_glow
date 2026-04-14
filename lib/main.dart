// import 'package:device_preview/device_preview.dart'; // Only enable for development
import 'package:mind_glow/routes/route_path.dart';
import 'package:mind_glow/utils/page_transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_glow/utils/page_transitions.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'controllers/localization_controller/localization_controller.dart';

import 'dependency/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Register and load saved language
  final locController = Get.put(LocalizationController(), permanent: true);
  await locController.loadSavedLocale();

  // Don't call WidgetsFlutterBinding.ensureInitialized() unless absolutely needed
  // It's called automatically by runApp()

  // Start the app immediately
  runApp(const MyApp());

  //  runApp(
  //    DevicePreview(
  //      enabled: true, // <-- TURN ON DEVICE PREVIEW ONLY IN DEVELOPMENT
  //      builder: (context) => const MyApp(),
  //     ),
  //  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: _lightTheme,
          initialBinding: InitialBinding(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
            Locale('ar'),
          ],
          routeInformationParser: RoutePath.router.routeInformationParser,
          routerDelegate: RoutePath.router.routerDelegate,
          routeInformationProvider: RoutePath.router.routeInformationProvider,

          // Remove DevicePreview builder for faster production startup
          // Uncomment the builder below only when using DevicePreview in development
          // builder: (context, widget) {
          //   widget = DevicePreview.appBuilder(context, widget);
          //   return widget;
          // },
          // locale: DevicePreview.locale(context),
        );
      },
    );
  }

  ThemeData get _lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme(), // Default font: Poppins
    // Custom page transitions to eliminate white flick during navigation
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: NoTransitionPageTransitionsBuilder(),
        TargetPlatform.iOS: NoTransitionPageTransitionsBuilder(),
        TargetPlatform.windows: NoTransitionPageTransitionsBuilder(),
        TargetPlatform.macOS: NoTransitionPageTransitionsBuilder(),
        TargetPlatform.linux: NoTransitionPageTransitionsBuilder(),
      },
    ),
  );
}