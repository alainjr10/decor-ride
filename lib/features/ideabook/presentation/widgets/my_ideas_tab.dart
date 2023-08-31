import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/ideabook/data/data_sources/general_ideas_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyIdeasTab extends ConsumerWidget {
  const MyIdeasTab({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.camera_alt_rounded,
                    size: 20.0,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.draw,
                    size: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Start Saving ideas to make your home design dream a reality",
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          8.vGap,
          ref.watch(getMyIdeasListtileItemsProvider).maybeWhen(
                orElse: () => const Text("Failed to get data"),
                loading: () {
                  return Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.primary,
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                data: (data) {
                  return data.fold((data) {
                    return RefreshIndicator(
                      onRefresh: () {
                        return ref
                            .refresh(getMyIdeasListtileItemsProvider.future);
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...data.map((e) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 24.0, 16.0),
                                  decoration: BoxDecoration(
                                    color: context.colorScheme.surface
                                        .withOpacity(0.7),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        e.name,
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                        width: 40.0,
                                        child: Image.asset(
                                          e.avatarImageUrl,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  thickness: 0.0,
                                  color: Colors.transparent,
                                  height: 16.0,
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  }, (error) => Text(error));
                },
              ),
        ],
      ),
    );
  }
}
