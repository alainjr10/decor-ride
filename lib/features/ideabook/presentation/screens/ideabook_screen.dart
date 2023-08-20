import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/outlined_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdeaBook extends ConsumerWidget {
  const IdeaBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 24.0, 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "4 IdeaBooks",
                  style: kH3TextStyle(context),
                ),
                CustomOutlinedButton.outlinedButton(
                  context: context,
                  text: 'CREATE',
                  onPressed: () {},
                  color: context.colorScheme.primary,
                  icon: true,
                  iconData: Icons.add,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
