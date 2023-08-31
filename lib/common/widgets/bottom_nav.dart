// ignore_for_file: must_be_immutable

import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatefulWidget {
  String location;
  BottomNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'Home',
      initialLocation: '/',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.notifications_rounded),
      activeIcon: Icon(Icons.notifications_rounded),
      label: 'Notifications',
      initialLocation: '/notifications',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.favorite_rounded),
      activeIcon: Icon(Icons.favorite_rounded),
      label: 'Ideabook',
      initialLocation: '/ideabook',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.person_4),
      activeIcon: Icon(Icons.account_circle),
      label: 'Profile',
      initialLocation: '/user-profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: context.colorScheme.onPrimary,
        backgroundColor: context.colorScheme.surface,
        selectedFontSize: 12,
        // unselectedItemColor: const Color(0xFF838383),
        unselectedItemColor: context.theme.disabledColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: widget.location == '/'
            ? 0
            : widget.location == '/notifications'
                ? 1
                : widget.location == '/ideabook'
                    ? 2
                    : 3,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    if (index == 3) {
      context.go('/user-profile');
    } else {
      router.go(location);
    }
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem({
    required this.initialLocation,
    required Widget icon,
    String? label,
    Widget? activeIcon,
  }) : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
