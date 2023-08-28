import 'package:decor_ride/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text("User Profile"),
            subtitle: Text("User Profile"),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              await ref.read(authRepoImplProvider).signOut();
              context.go('/');
            },
          ),
        ],
      ),
    );
  }
}
