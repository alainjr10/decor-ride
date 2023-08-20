import 'package:decor_ride/common/widgets/bottom_nav.dart';
import 'package:decor_ride/features/ideabook/presentation/screens/ideabook_screen.dart';
import 'package:decor_ride/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:decor_ride/features/profile/presentation/screens/profile_screen.dart';
import 'package:decor_ride/homescreen.dart';
import 'package:decor_ride/presentation/screens/product_listing/category_products_screen.dart';
import 'package:decor_ride/presentation/screens/product_listing/product_categories_screen.dart';
import 'package:decor_ride/screens/place_object.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final _auth = FirebaseAuth.instance;

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  // redirect: (context, state) {
  //   if (_auth.currentUser == null) {
  //     return '/login';
  //   }
  //   return '/home-screen';
  // },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: WillPopScope(
              child: BottomNavBar(
                location: state.location,
                child: child,
              ),
              // on will pop, ask user if they really want to exit using a snack, on double tap backbutton, exit
              onWillPop: () async {
                final isFirstRouteInCurrentTab =
                    !await _shellNavigatorKey.currentState!.maybePop();
                if (isFirstRouteInCurrentTab) {
                  if (_shellNavigatorKey.currentState!.canPop()) {
                    return false;
                  } else {
                    return tapAgainToExitFn(context);
                  }
                }
                return isFirstRouteInCurrentTab;
              }),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => const Notifications(),
        ),
        GoRoute(
          path: '/ideabook',
          builder: (context, state) => const IdeaBook(),
        ),
        GoRoute(
          path: '/user-profile',
          builder: (context, state) => const UserProfile(),
        ),
      ],
    ),
    // GoRoute(
    //   path: '/signup',
    //   builder: (context, state) => const SignUp(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'place_object',
          builder: (context, state) => const PlaceObjectScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/product_categories_screen',
      builder: (context, state) => const ProductCategoriesScreen(),
    ),
    GoRoute(
      path: '/category_products_screen/:categoryTag',
      name: 'category_products_screen',
      builder: (context, state) => CategoryProductsScreen(
        categoryTag: state.pathParameters['categoryTag']!,
      ),
    ),
  ],
);

DateTime? _lastPressed;
Future<bool> tapAgainToExitFn(context) {
  if (_lastPressed == null ||
      DateTime.now().difference(_lastPressed!) > const Duration(seconds: 2)) {
    _lastPressed = DateTime.now();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Press again to exit'),
          duration: Duration(seconds: 1),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          )),
    );

    return Future.value(false);
  }
  return Future.value(true);
}
