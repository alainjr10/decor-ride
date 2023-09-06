import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/bottom_nav.dart';
import 'package:decor_ride/features/ar_and_products/presentation/screens/ar_main_view.dart';
import 'package:decor_ride/features/ar_and_products/presentation/screens/category_products_screen.dart';
import 'package:decor_ride/features/ar_and_products/presentation/screens/product_categories_screen.dart';
import 'package:decor_ride/features/auth/presentation/screens/email_screen.dart';
import 'package:decor_ride/features/auth/presentation/screens/password_screen.dart';
import 'package:decor_ride/features/auth/presentation/screens/personal_details.dart';
import 'package:decor_ride/features/auth/presentation/screens/welcome_screen.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/presentation/screens/create_ideabook.dart';
import 'package:decor_ride/features/ideabook/presentation/screens/ideabook_details_screen.dart';
import 'package:decor_ride/features/ideabook/presentation/screens/ideabook_screen.dart';
import 'package:decor_ride/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:decor_ride/features/profile/presentation/screens/profile_screen.dart';
import 'package:decor_ride/homescreen.dart';
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
          builder: (context, state) {
            return HomeScreen();
          },
          redirect: (context, state) {
            User? firebaseUser = FirebaseAuth.instance.currentUser;
            if (firebaseUser != null) {
              "Redirecting now......".log();
              debugPrint("Debug print Redirecting now......");
              print("Print Redirecting now......");
              return null;
            }
            if (firebaseUser == null) {
              return "/welcome";
            }
            return null;
          },
          // builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/notifications',
          builder: (context, state) => const Notifications(),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/ideabook',
          builder: (context, state) => const IdeaBook(),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'create_ideabook',
              name: 'createIdeabook',
              builder: (context, state) => const CreateIdeabookScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'ideabook_details/:ideabookId',
              name: 'ideabookDetails',
              builder: (context, state) {
                GetIdeabookEntity ideabookEntity =
                    state.extra as GetIdeabookEntity;
                return IdeabookDetailsScreen(
                  ideabookEntity: ideabookEntity,
                  ideabookId: state.pathParameters['ideabookId']!,
                );
              },
            ),
          ],
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: '/user-profile',
          builder: (context, state) => const UserProfile(),
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/ar_main_view',
      name: 'arMainView',
      builder: (context, state) => const ARMainView(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/product_categories_screen',
      builder: (context, state) => const ProductCategoriesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/category_products_screen/:categoryTag',
      name: 'category_products_screen',
      builder: (context, state) => CategoryProductsScreen(
        categoryTag: state.pathParameters['categoryTag']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/enter_email',
      builder: (context, state) => const EnterEmailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/enter_password/:authType',
      builder: (context, state) => EnterPasswordScreen(
        authType: state.pathParameters['authType']!,
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/personal_details',
      builder: (context, state) => const PersonalDetailsScreen(),
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
