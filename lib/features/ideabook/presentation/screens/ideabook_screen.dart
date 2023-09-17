import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/common/widgets/outlined_button.dart';
import 'package:decor_ride/features/ideabook/presentation/providers/get_ideabooks_provider.dart';
import 'package:decor_ride/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IdeaBook extends ConsumerWidget {
  const IdeaBook({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideabooksNotifierProvider = ref.watch(getAllIdeabooksProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return ref.refresh(getAllIdeabooksProvider.future);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ideabooksNotifierProvider.maybeWhen(
                    orElse: () {
                      return Text(
                        "0 IdeaBooks",
                        style: kH3TextStyle(context),
                      );
                    },
                    data: (data) {
                      return data.fold(
                        (ideabooks) {
                          return Text(
                            "${ideabooks.length} IdeaBooks",
                            style: kH3TextStyle(context),
                          );
                        },
                        (error) {
                          return Text(
                            "0 IdeaBooks",
                            style: kH3TextStyle(context),
                          );
                        },
                      );
                    },
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
              ideabooksNotifierProvider.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message, stacktrace) {
                  return Center(
                    child: Text(message.toString()),
                  );
                },
                data: (data) {
                  return data.fold(
                    (ideabooks) {
                      if (ideabooks.isEmpty) {
                        return const Center(
                          child: Text("No IdeaBooks"),
                        );
                      } else {
                        return Flexible(
                          child: GridView.count(
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 8,
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            childAspectRatio: (1 / 1.3),
                            children: <Widget>[
                              ...ideabooks.map(
                                (e) => InkWell(
                                  onTap: () {
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return SelectSeatScreen();
                                    // }));
                                    // context.push to ideabook details screen with id and getideabookentity
                                    context.push(
                                      '/ideabook/ideabook_details/${e.ideabookId}',
                                      extra: e,
                                    );
                                  },
                                  child: SizedBox(
                                    height: 300.0,
                                    width: 140.0,
                                    child: Card(
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 120.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  context.colorScheme.surface,
                                              // borderRadius: BorderRadius.circular(.0),
                                            ),
                                          ),
                                          8.vGap,
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.ideabookName,
                                                ),
                                                40.vGap,
                                                Text(
                                                  e.ideas == null ||
                                                          e.ideas!.isEmpty
                                                      ? "No Ideas saved"
                                                      : "${e.ideas!.length} Ideas",
                                                  style: context
                                                      .textTheme.bodySmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    (error) => Center(
                      child: Text(error.toString()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
