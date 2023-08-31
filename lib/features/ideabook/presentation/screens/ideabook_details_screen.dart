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
                    // expandedHeight: 180.0,
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







// class SelectSeatScreen extends StatefulWidget {
//   const SelectSeatScreen({super.key});

//   @override
//   State<SelectSeatScreen> createState() => _SelectSeatScreenState();
// }

// class _SelectSeatScreenState extends State<SelectSeatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     List seats = List.generate(70, (index) => index + 1);
//     // seats 1, 2 and 3 on the left, and seats 4 and 5 of each row on the right
//     List leftSeats = seats.where((element) => element % 6 < 4).toList();
//     // create a map of left seats, which will be used to create the left side of the grid. this map should group the leftSeats list into groups of 3
//     List rightSeats = seats.where((element) => element % 6 > 3).toList();
//     Map<int, List> leftSeatsMap = {};
//     Map<int, List> rightSeatsMap = {};

//     for (var i = 1; i < 14; i++) {
//       leftSeatsMap[i] = leftSeats.sublist(i * 3 - 3, i * 3);
//       rightSeatsMap[i] = rightSeats.sublist(i * 2 - 2, i * 2);
//     }
//     log("left seats list is $leftSeats");
//     log("right seats list is $rightSeats");
//     log("left seats map is $leftSeatsMap");
//     log("right seats map is $rightSeatsMap");
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(left: 40.0),
//               width: 240.0,
//               // child:
//               //  GridView.builder(
//               //     shrinkWrap: true,
//               //     physics: const NeverScrollableScrollPhysics(),
//               //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               //         crossAxisCount: 6),
//               //     itemCount: seats.length,
//               //     itemBuilder: (context, index) {
//               //       return UnconstrainedBox(
//               //         child: Container(
//               //           width: 30.0,
//               //           height: 30.0,
//               //           margin: const EdgeInsets.all(4.0),
//               //           decoration: BoxDecoration(
//               //             color: Colors.yellow,
//               //             borderRadius: BorderRadius.circular(4.0),
//               //           ),
//               //           child: Center(
//               //               child: Text(
//               //             seats[index].toString(),
//               //             style: const TextStyle(
//               //                 fontWeight: FontWeight.w700, color: Colors.black),
//               //           )),
//               //         ),
//               //       );
//               //     }),

//               child: ListView.separated(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 14,
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(height: 4.0);
//                 },
//                 itemBuilder: (context, mainIndex) {
//                   return Row(
//                     children: [],
//                   );
//                 },
//               ),

//               // ListView.separated(
//               //   shrinkWrap: true,
//               //   physics: const NeverScrollableScrollPhysics(),
//               //   itemCount: 14,
//               //   separatorBuilder: (context, index) {
//               //     return const SizedBox(height: 4.0);
//               //   },
//               //   itemBuilder: (context, mainIndex) {
//               //     if (mainIndex == 0) {
//               //       return SizedBox(
//               //         height: 30.0,
//               //         child: ListView.separated(
//               //           shrinkWrap: true,
//               //           physics: const NeverScrollableScrollPhysics(),
//               //           scrollDirection: Axis.horizontal,
//               //           itemCount: 5,
//               //           separatorBuilder: (context, index) {
//               //             if (index == 2) {
//               //               return Padding(
//               //                 padding: const EdgeInsets.only(right: 8.0),
//               //                 child: Visibility(
//               //                   visible: false,
//               //                   maintainSize: true,
//               //                   maintainAnimation: true,
//               //                   maintainState: true,
//               //                   child: Container(
//               //                     width: 30.0,
//               //                     color: Colors.white,
//               //                   ),
//               //                 ),
//               //               );
//               //             }
//               //             return const SizedBox();
//               //           },
//               //           itemBuilder: (context, index) {
//               //             if (index == 1 || index == 2) {
//               //               return Visibility(
//               //                 visible: false,
//               //                 maintainSize: true,
//               //                 maintainAnimation: true,
//               //                 maintainState: true,
//               //                 child: Padding(
//               //                   padding: const EdgeInsets.only(right: 8.0),
//               //                   child: Container(
//               //                     width: 30.0,
//               //                     color: Colors.yellow,
//               //                   ),
//               //                 ),
//               //               );
//               //             }
//               //             return Align(
//               //               alignment: Alignment.topLeft,
//               //               child: Padding(
//               //                 padding: const EdgeInsets.only(right: 8.0),
//               //                 child: Container(
//               //                   height: 40,
//               //                   width: 30.0,
//               //                   color: Colors.yellow,
//               //                   child: Center(
//               //                       child: Text(
//               //                     mainIndex.toString(),
//               //                     style: const TextStyle(
//               //                         fontWeight: FontWeight.w700,
//               //                         color: Colors.black),
//               //                   )),
//               //                 ),
//               //               ),
//               //             );
//               //           },
//               //         ),
//               //       );
//               //     } else if (mainIndex == 13) {
//               //       return SizedBox(
//               //         height: 30.0,
//               //         child: ListView.separated(
//               //           shrinkWrap: true,
//               //           physics: const NeverScrollableScrollPhysics(),
//               //           scrollDirection: Axis.horizontal,
//               //           itemCount: 6,
//               //           separatorBuilder: (context, index) {
//               //             return const SizedBox();
//               //           },
//               //           itemBuilder: (context, index) {
//               //             return Align(
//               //               alignment: Alignment.topLeft,
//               //               child: Padding(
//               //                 padding: const EdgeInsets.only(right: 8.0),
//               //                 child: Container(
//               //                   height: 40,
//               //                   width: 30.0,
//               //                   color: Colors.yellow,
//               //                   child: Center(
//               //                       child: Text(
//               //                     mainIndex.toString(),
//               //                     style: const TextStyle(
//               //                         fontWeight: FontWeight.w700,
//               //                         color: Colors.black),
//               //                   )),
//               //                 ),
//               //               ),
//               //             );
//               //           },
//               //         ),
//               //       );
//               //     }

//               //     /// ELSE BETWEEN SECOND AND LAST ROWS
//               //     return SizedBox(
//               //       height: 30.0,
//               //       child: ListView.separated(
//               //         shrinkWrap: true,
//               //         physics: const NeverScrollableScrollPhysics(),
//               //         scrollDirection: Axis.horizontal,
//               //         itemCount: 5,
//               //         separatorBuilder: (context, index) {
//               //           if (index == 2) {
//               //             return Padding(
//               //               padding: const EdgeInsets.only(right: 8.0),
//               //               child: Visibility(
//               //                 visible: false,
//               //                 maintainSize: true,
//               //                 maintainAnimation: true,
//               //                 maintainState: true,
//               //                 child: Container(
//               //                   width: 30.0,
//               //                   color: Colors.white,
//               //                 ),
//               //               ),
//               //             );
//               //           }
//               //           return const SizedBox();
//               //         },
//               //         itemBuilder: (context, index) {
//               //           return Align(
//               //             alignment: Alignment.topLeft,
//               //             child: Padding(
//               //               padding: const EdgeInsets.only(right: 8.0),
//               //               child: Container(
//               //                 height: 30,
//               //                 width: 30.0,
//               //                 color: Colors.yellow,
//               //                 child: Center(
//               //                     child: Text(
//               //                   mainIndex.toString(),
//               //                   style: const TextStyle(
//               //                       fontWeight: FontWeight.w700,
//               //                       color: Colors.black),
//               //                 )),
//               //               ),
//               //             ),
//               //           );
//               //         },
//               //       ),
//               //     );
//               //   },
//               // ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
