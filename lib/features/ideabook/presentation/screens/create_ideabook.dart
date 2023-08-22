import 'package:decor_ride/app/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateIdeabookScreen extends ConsumerWidget {
  const CreateIdeabookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideabookNameController = TextEditingController();
    final ideabookDescriptionController = TextEditingController();
    bool makePrivate = false;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("New IdeaBook"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("CREATE"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
        child: Column(
          children: [
            TextFormField(
              controller: ideabookNameController,
              decoration: InputDecoration(
                labelText: "Ideabook Name",
                hintText: "Ideabook Name",
                hintStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
                labelStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
            32.vGap,
            TextFormField(
              controller: ideabookDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Add a brief description",
                hintText: "Add a brief description",
                hintStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
                labelStyle: TextStyle(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
            40.vGap,
            SwitchListTile(
              value: makePrivate,
              onChanged: (value) {
                makePrivate = value;
              },
              title: const Text("Make Ideabook Private"),
            ),
          ],
        ),
      ),
    );
  }
}
