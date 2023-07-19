import 'package:decor_ride/app/providers/app_theme_provider.dart';
import 'package:decor_ride/app/themes.dart';
import 'package:decor_ride/firebase_options.dart';
import 'package:decor_ride/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'ARCore Flutter Plugin Example',
          routerConfig: router,
          theme: ThemeColor.themeData(ref.watch(appThemeProvider), context),
          // theme: ThemeData(
          //   useMaterial3: true,
          //   primarySwatch: Colors.blue,
          // ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
    //  MaterialApp.router(
    //   title: 'ARCore Flutter Plugin Example',
    //   routerConfig: router,
    //   theme: ThemeColor.themeData(ref.watch(appThemeProvider), context),
    //   // theme: ThemeData(
    //   //   useMaterial3: true,
    //   //   primarySwatch: Colors.blue,
    //   // ),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}
