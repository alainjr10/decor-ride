import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/outlined_button.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IdeaBook extends ConsumerWidget {
  const IdeaBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> ideaBooks = ["Book 1", "Book 2", "Book 3", "Book 4"];
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
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  onPressed: () {
                    context.go('/ideabook/create_ideabook');
                  },
                  color: context.colorScheme.primary,
                  icon: true,
                  iconData: Icons.add,
                ),
              ],
            ),
            24.vGap,
            Flexible(
              child: GridView.count(
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: (1 / 1.3),
                children: <Widget>[
                  ...ideaBooks.map(
                    (e) => SizedBox(
                      height: 300.0,
                      width: 140.0,
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                // borderRadius: BorderRadius.circular(.0),
                              ),
                            ),
                            8.vGap,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e,
                                  ),
                                  40.vGap,
                                  Text(
                                    "No Ideas saved",
                                    style: context.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
