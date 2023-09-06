import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> qtyList = List.generate(30, (index) => index + 1);
    'qty list is ${qtyList.toString()}'.log();
    int value = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total (6 items)',
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontSize: 16.0),
                      ),
                      Text(
                        'XAF 155000',
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: context.colorScheme.onPrimary.withOpacity(0.3),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 12.0, 16.0, 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/furniture_assets/counter_bar_stool.jpg',
                              height: 90.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            16.vGap,
                            Container(
                              height: 30.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: context.colorScheme.onPrimary
                                      .withOpacity(0.6),
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButton(
                                value: value,
                                iconSize: 20.0,
                                underline: Container(
                                  height: 0.0,
                                  color: context.colorScheme.onPrimary
                                      .withOpacity(0.3),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                isExpanded: true,
                                items: qtyList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.toString(),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.hGap,
                      Flexible(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The sawyer dining chair black wood and rope',
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            4.vGap,
                            Text(
                              'Sold by Houzz',
                              style: context.textTheme.labelMedium,
                            ),
                            16.vGap,
                            Text(
                              'XAF 25000',
                              style: context.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            4.vGap,
                            Text(
                              'Ready to ship to Douala, Yaounde and Buea in 1-2 days',
                              style: context.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
            ),
            child: CustomElevatedButton(
              height: 40.0,
              text: 'PROCEED TO CHECKOUT',
              onPressed: () {
                context.push('checkout_screen');
              },
            ),
          ),
        ],
      ),
    );
  }
}
