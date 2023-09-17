import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> dropdownItems = ['XAF', 'USD', 'EUR'];
    String dropdownValue = dropdownItems[0];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      items: dropdownItems
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.shopping_cart,
                                    size: 20.0,
                                  ),
                                  8.hGap,
                                  Text(e),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {},
                      value: dropdownValue,
                      underline: 0.vGap,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 20.0,
                    ),
                    Text(
                      'XAF 84300',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 20.0,
              color: context.theme.canvasColor,
              thickness: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Address',
                    style: context.textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  24.vGap,
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  4.vGap,
                  Text(
                    '1234 Main Street',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  4.vGap,
                  Text(
                    'New York, NY 10001',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  4.vGap,
                  Text(
                    'United States',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  8.vGap,
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  8.vGap,
                  Text(
                    'Visa **** 4242',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  8.vGap,
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  8.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'XAF 84300',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  4.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'XAF 84300',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  4.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'XAF 84300',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  4.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        'XAF 84300',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  8.vGap,
                  Text(
                    'Shipping Method',
                    style: Theme.of(context).textTheme.titleSmall,
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
