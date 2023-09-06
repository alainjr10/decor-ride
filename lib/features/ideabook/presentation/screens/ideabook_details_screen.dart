import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/features/ideabook/domain/entities/get_ideabook_entity.dart';
import 'package:decor_ride/features/ideabook/presentation/widgets/more_ideas_tab.dart';
import 'package:decor_ride/features/ideabook/presentation/widgets/my_ideas_tab.dart';
import 'package:decor_ride/features/ideabook/presentation/widgets/rich_sliver_appbar_title.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IdeabookDetailsScreen extends HookConsumerWidget {
  const IdeabookDetailsScreen(
      {super.key, required this.ideabookEntity, this.ideabookId});
  final GetIdeabookEntity ideabookEntity;
  final String? ideabookId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> tabs = ["MY IDEAS", "MORE IDEAS"];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ideabookEntity.ideabookName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    toolbarHeight: 100.0,
                    title:
                        SliverAppbarRichTitle(ideabookEntity: ideabookEntity),
                    automaticallyImplyLeading: false,
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: false,
                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      // These are the widgets to put in each tab in the tab bar.
                      tabs: tabs.map((String name) => Tab(text: name)).toList(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      labelStyle: context.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                      unselectedLabelColor: context.colorScheme.onPrimary,
                      unselectedLabelStyle:
                          context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: name == tabs[0]
                              ? MyIdeasTab(name: name)
                              : MoreIdeasTab(name: name),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
