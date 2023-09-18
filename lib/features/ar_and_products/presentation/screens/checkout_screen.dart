import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/common/widgets/custom_text_fields.dart';
import 'package:decor_ride/features/ar_and_products/domain/entities/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CheckoutScreen extends HookConsumerWidget {
  const CheckoutScreen(
      {super.key, required this.totalAmount, required this.cartItems});

  final double totalAmount;
  final List<CartItemEntity> cartItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(GlobalKey<FormState>.new, const []);
    List<String> dropdownItems = ['XAF', 'USD', 'EUR'];
    List<String> availableCountries = ['Cameroon', 'Nigeria', 'Kenya'];
    List<String> availableStates = [
      'Littoral',
      'West',
      'North',
      'South',
      'East',
      'Northwest',
      'Southwest',
      'Center',
      'Adamaoua',
      'Far North'
    ];
    final dropdownValue = useState<String>(dropdownItems[0]);
    final fullNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressLineController = useTextEditingController();
    final cityController = useTextEditingController();
    final zipCodeController = useTextEditingController();
    final selectedCountry = useState<String>(availableCountries[0]);
    final selectedState = useState<String>(availableStates[0]);

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
                      onChanged: (value) =>
                          dropdownValue.value = value as String,
                      value: dropdownValue.value,
                      underline: 0.vGap,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 20.0,
                    ),
                    Text(
                      'XAF ${totalAmount.toInt()}',
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shipping Address',
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    32.vGap,
                    CustomTextField(
                      controller: fullNameController,
                      hintText: '',
                      labelText: 'Full Name',
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    16.vGap,
                    CustomTextField(
                      controller: addressLineController,
                      hintText: '',
                      labelText: "Address Line 1",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Address cannot be empty";
                        }
                        return null;
                      },
                    ),
                    16.vGap,
                    DropdownButtonFormField(
                      items: availableCountries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              alignment: AlignmentDirectional.center,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          selectedCountry.value = value as String,
                      value: selectedCountry.value,
                      isDense: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 20.0,
                    ),
                    16.vGap,
                    CustomTextField(
                      controller: cityController,
                      hintText: '',
                      labelText: "City",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "City cannot be empty";
                        }
                        return null;
                      },
                    ),
                    16.vGap,
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            items: availableStates
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    alignment: AlignmentDirectional.center,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                selectedState.value = value as String,
                            value: selectedState.value,
                            isDense: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 20.0,
                          ),
                        ),
                        12.hGap,
                        Expanded(
                          child: CustomTextField(
                            controller: zipCodeController,
                            hintText: '',
                            labelText: "Postal Code",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Postal code cannot be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    16.vGap,
                    CustomTextField(
                      controller: phoneController,
                      hintText: '',
                      labelText: "Phone number",
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return "Phone number cannot be empty";
                        }
                        return null;
                      },
                    ),
                    24.vGap,
                    CustomElevatedButton(
                      text: 'CONTINUE',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 32.0,
              color: context.theme.canvasColor,
              thickness: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  16.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal:',
                        style: context.textTheme.bodyMedium!.copyWith(),
                      ),
                      Text(
                        'XAF ${totalAmount.toInt()}',
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  8.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery:',
                        style: context.textTheme.bodyMedium!.copyWith(),
                      ),
                      Text(
                        'FREE',
                        style: context.textTheme.bodyMedium!.copyWith(),
                      ),
                    ],
                  ),
                  8.vGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimated Tax',
                        style: context.textTheme.bodyMedium!.copyWith(),
                      ),
                      Text(
                        '_',
                        style: context.textTheme.bodyMedium!.copyWith(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: context.colorScheme.onPrimary.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'XAF ${totalAmount.toInt()}',
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            8.vGap,
          ],
        ),
      ),
    );
  }
}
